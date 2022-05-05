package com.si0005hp;

public class ParserDebugger extends JackBaseVisitor<Void> {
    @Override
    public Void visitProgram(JackParser.ProgramContext ctx) {
        System.out.printf("visitProgram: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitClassDec(JackParser.ClassDecContext ctx) {
        System.out.printf("visitClassDec: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitClassVarDec(JackParser.ClassVarDecContext ctx) {
        System.out.printf("visitClassVarDec: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitType(JackParser.TypeContext ctx) {
        System.out.printf("visitType: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitSubroutineDec(JackParser.SubroutineDecContext ctx) {
        System.out.printf("visitSubroutineDec: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitParameterList(JackParser.ParameterListContext ctx) {
        System.out.printf("visitParameterList: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitSubroutineBody(JackParser.SubroutineBodyContext ctx) {
        System.out.printf("visitSubroutineBody: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitVarDec(JackParser.VarDecContext ctx) {
        System.out.printf("visitVarDec: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitClassName(JackParser.ClassNameContext ctx) {
        System.out.printf("visitClassName: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitSubroutineName(JackParser.SubroutineNameContext ctx) {
        System.out.printf("visitSubroutineName: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitVarName(JackParser.VarNameContext ctx) {
        System.out.printf("visitVarName: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitStatements(JackParser.StatementsContext ctx) {
        System.out.printf("visitStatements: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitStatement(JackParser.StatementContext ctx) {
        System.out.printf("visitStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitLetStatement(JackParser.LetStatementContext ctx) {
        System.out.printf("visitLetStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitIfStatement(JackParser.IfStatementContext ctx) {
        System.out.printf("visitIfStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitWhileStatement(JackParser.WhileStatementContext ctx) {
        System.out.printf("visitWhileStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitDoStatement(JackParser.DoStatementContext ctx) {
        System.out.printf("visitDoStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitReturnStatement(JackParser.ReturnStatementContext ctx) {
        System.out.printf("visitReturnStatement: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitExpression(JackParser.ExpressionContext ctx) {
        System.out.printf("visitExpression: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitInt(JackParser.IntContext ctx) {
        System.out.printf("visitInt: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitString(JackParser.StringContext ctx) {
        System.out.printf("visitString: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitKeyword(JackParser.KeywordContext ctx) {
        System.out.printf("visitKeyword: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitVarRef(JackParser.VarRefContext ctx) {
        System.out.printf("visitVar: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitSubscript(JackParser.SubscriptContext ctx) {
        System.out.printf("visitSubscript: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitCall(JackParser.CallContext ctx) {
        System.out.printf("visitCall: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitGrouping(JackParser.GroupingContext ctx) {
        System.out.printf("visitGrouping: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitUnary(JackParser.UnaryContext ctx) {
        System.out.printf("visitUnary: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitSubroutineCall(JackParser.SubroutineCallContext ctx) {
        System.out.printf("visitSubroutineCall: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitExpressionList(JackParser.ExpressionListContext ctx) {
        System.out.printf("visitExpressionList: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitOp(JackParser.OpContext ctx) {
        System.out.printf("visitOp: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitUnaryOp(JackParser.UnaryOpContext ctx) {
        System.out.printf("visitUnaryOp: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

    @Override
    public Void visitKeywordConstant(JackParser.KeywordConstantContext ctx) {
        System.out.printf("visitKeywordConstant: %s\n", ctx.getText());
        return visitChildren(ctx);
    }

}
