package com.si0005hp;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class Compiler extends JackBaseVisitor<Void> {

    private final String className;
    private final VMWriter writer;

    @Override
    public Void visitSubroutineDec(JackParser.SubroutineDecContext ctx) {
        var name = String.format("%s.%s", className, ctx.subroutineName().getText());
        var nLocals = ctx.parameterList().varName().size(); // TODO: Not params, but locals
        writer.writeFunction(name, nLocals);
        return visitChildren(ctx);
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
    public Void visitSubroutineCall(JackParser.SubroutineCallContext ctx) {
        ctx.expressionList().accept(this);

        var name = ctx.subroutineName().getText();
        if (ctx.receiver != null) {
            name = String.format("%s.%s", ctx.receiver.getText(), name);
        }
        writer.writeCall(name, ctx.expressionList().expression().size());
        writer.writePop(VMWriter.Segment.TEMP, 0);
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
}
