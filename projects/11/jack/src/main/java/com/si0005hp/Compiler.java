package com.si0005hp;

import lombok.RequiredArgsConstructor;

/**
 * Compiler corresponds with a class.
 */
@RequiredArgsConstructor
public class Compiler extends JackBaseVisitor<Void> {

    private final SymbolTable symbolTable = new SymbolTable();

    private final String className;
    private final VMWriter writer;

    private int whileLabelIndex = 0;
    private int ifLabelIndex = 0;

    private void resetLabelIndex() {
        whileLabelIndex = 0;
        ifLabelIndex = 0;
    }

    private int numFields = 0;

    @Override
    public Void visitClassVarDec(JackParser.ClassVarDecContext ctx) {
        ctx.varName().forEach(varName -> {
            symbolTable.define(varName.getText(), ctx.type().getText(), ctx.STATIC() != null ?
                    SymbolTable.Kind.STATIC : SymbolTable.Kind.FIELD);
            numFields++;
        });
        return null;
    }

    @Override
    public Void visitSubroutineDec(JackParser.SubroutineDecContext ctx) {
        resetLabelIndex();
        // Initialize symbolTable and define function parameters
        symbolTable.startSubroutine();
        var params = ctx.parameterList();
        for (int i = 0; i < params.varName().size(); i++) {
            symbolTable.define(params.varName(i).getText(), params.type(i).getText(),
                    SymbolTable.Kind.ARG);
        }

        var name = String.format("%s.%s", className, ctx.subroutineName().getText());
        var nLocals = ctx.subroutineBody()
                .varDec()
                .stream()
                .mapToInt(varDec -> varDec.varName().size())
                .sum();

        writer.writeFunction(name, nLocals);
        if (ctx.METHOD() != null) {
            // Set receiver (argument 0) to pointer 0 for methods
            writer.writePush(VMWriter.Segment.ARG, 0);
            writer.writePop(VMWriter.Segment.POINTER, 0);
        } else if (ctx.CONSTRUCTOR() != null) {
            // Call Memory.alloc in case of constructor
            writer.writePush(VMWriter.Segment.CONST, numFields);
            writer.writeCall("Memory.alloc", 1);
            writer.writePop(VMWriter.Segment.POINTER, 0);
        }
        return visitChildren(ctx);
    }


    public Void visitVarDec(JackParser.VarDecContext ctx) {
        var type = ctx.type().getText();
        ctx.varName().forEach(v -> symbolTable.define(v.getText(), type, SymbolTable.Kind.VAR));
        return null;
    }

    @Override
    public Void visitLetStatement(JackParser.LetStatementContext ctx) {
        ctx.rhs.accept(this);

        // TODO: Case of subscript
        // TODO: empty error handling
        var symbol = symbolTable.lookupSymbol(ctx.lhs.getText()).get();
        writer.writePop(resolveSymbolSegment(symbol), symbol.getIndex());
        return null;
    }

    @Override
    public Void visitIfStatement(JackParser.IfStatementContext ctx) {
        var trueLabel = String.format("IF_TRUE%s", ifLabelIndex);
        var falseLabel = String.format("IF_FALSE%s", ifLabelIndex);
        var endLabel = String.format("IF_END%s", ifLabelIndex);
        ifLabelIndex++;

        ctx.expression().accept(this);
        writer.writeIfGoto(trueLabel);
        writer.writeGoto(falseLabel);
        writer.writeLabel(trueLabel);
        ctx.thenBlock.accept(this);

        if (ctx.elseBlock == null) {
            writer.writeLabel(falseLabel);
        } else {
            writer.writeGoto(endLabel);
            writer.writeLabel(falseLabel);
            ctx.elseBlock.accept(this);
            writer.writeLabel(endLabel);
        }
        return null;
    }

    @Override
    public Void visitWhileStatement(JackParser.WhileStatementContext ctx) {
        var expLabel = String.format("WHILE_EXP%s", whileLabelIndex);
        var endLabel = String.format("WHILE_END%s", whileLabelIndex);
        whileLabelIndex++;

        writer.writeLabel(expLabel);
        ctx.expression().accept(this);
        writer.writeArithmetic(VMWriter.ArithmeticCommand.NOT);
        writer.writeIfGoto(endLabel);
        ctx.statements().accept(this);
        writer.writeGoto(expLabel);
        writer.writeLabel(endLabel);
        return null;
    }

    @Override
    public Void visitDoStatement(JackParser.DoStatementContext ctx) {
        ctx.subroutineCall().accept(this);
        writer.writePop(VMWriter.Segment.TEMP, 0);
        return null;
    }

    @Override
    public Void visitReturnStatement(JackParser.ReturnStatementContext ctx) {
        if (ctx.expression() == null) {
            // Push 0 if return value does not exist
            writer.writePush(VMWriter.Segment.CONST, 0);
        } else {
            ctx.expression().accept(this);
        }
        writer.writeReturn();
        return null;
    }

    @Override
    public Void visitExpression(JackParser.ExpressionContext ctx) {
        ctx.term().get(0).accept(this);
        for (int i = 1; i < ctx.term().size(); i++) {
            ctx.term().get(i).accept(this);
            ctx.op(i - 1).accept(this);
        }
        return null;
    }

    @Override
    public Void visitVarRef(JackParser.VarRefContext ctx) {
        // TODO: empty error handling
        var symbol = symbolTable.lookupSymbol(ctx.getText()).get();
        writer.writePush(resolveSymbolSegment(symbol), symbol.getIndex());
        return null;
    }

    private VMWriter.Segment resolveSymbolSegment(SymbolTable.Symbol symbol) {
        switch (symbol.getKind()) {
            case VAR:
                return VMWriter.Segment.LOCAL;
            case ARG:
                return VMWriter.Segment.ARG;
            case FIELD:
                return VMWriter.Segment.THIS;
            default:
                // TODO: Other segments
                throw new RuntimeException("Not implemented");
        }
    }

    @Override
    public Void visitUnary(JackParser.UnaryContext ctx) {
        ctx.term().accept(this);
        switch (ctx.unaryOp().getText()) {
            case "-":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.NEG);
                break;
            case "~":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.NOT);
                break;
        }
        return null;
    }

    @Override
    public Void visitSubroutineCall(JackParser.SubroutineCallContext ctx) {
        var subroutineName = ctx.subroutineName().getText();
        int nArgs = ctx.expressionList().expression().size();

        if (ctx.receiver != null) {
            var opt = symbolTable.lookupSymbol(ctx.receiver.getText());
            if (opt.isPresent()) {
                // Receiver is an instance
                var symbol = opt.get();
                writer.writePush(resolveSymbolSegment(symbol), symbol.getIndex());
                subroutineName = String.format("%s.%s", symbol.getType(), subroutineName);
                nArgs += 1;
            } else {
                // Receiver is a class
                subroutineName = String.format("%s.%s", ctx.receiver.getText(), subroutineName);
            }
        } else {
            // If no receiver, then its one of other methods of self
            writer.writePush(VMWriter.Segment.POINTER, 0);
            subroutineName = String.format("%s.%s", className, subroutineName);
            nArgs += 1;
        }

        ctx.expressionList().accept(this);
        writer.writeCall(subroutineName, nArgs);
        return null;
    }

    @Override
    public Void visitInt(JackParser.IntContext ctx) {
        writer.writePush(VMWriter.Segment.CONST, Integer.parseInt(ctx.getText()));
        return null;
    }

    @Override
    public Void visitOp(JackParser.OpContext ctx) {
        switch (ctx.getText()) {
            case "+":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.ADD);
                break;
            case "-":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.SUB);
                break;
            case "*":
                writer.writeCall("Math.multiply", 2);
                break;
            case "/":
                writer.writeCall("Math.divide", 2);
                break;
            case "&":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.AND);
                break;
            case "|":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.OR);
                break;
            case "<":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.LT);
                break;
            case ">":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.GT);
                break;
            case "=":
                writer.writeArithmetic(VMWriter.ArithmeticCommand.EQ);
                break;
        }
        return null;
    }

    @Override
    public Void visitKeywordConstant(JackParser.KeywordConstantContext ctx) {
        switch (ctx.getText()) {
            case "true":
                writer.writePush(VMWriter.Segment.CONST, 0);
                writer.writeArithmetic(VMWriter.ArithmeticCommand.NOT);
                break;
            case "false":
            case "null":
                writer.writePush(VMWriter.Segment.CONST, 0);
                break;
            case "this":
                writer.writePush(VMWriter.Segment.POINTER, 0);
                break;
        }
        return null;
    }
}
