package com.si0005hp;

import lombok.RequiredArgsConstructor;

import java.io.PrintStream;

@RequiredArgsConstructor
public class VMWriter {

    private final PrintStream out;

    enum Segment {
        CONST("constant"),
        ARG("argument"),
        LOCAL("local"),
        STATIC("static"),
        THIS("this"),
        THAT("that"),
        POINTER("pointer"),
        TEMP("temp");

        private final String name;

        Segment(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    enum ArithmeticCommand {
        ADD, SUB, NEG, EQ, GT, LT, AND, OR, NOT;

        @Override
        public String toString() {
            return name().toLowerCase();
        }
    }

    public void writePush(Segment segment, int index) {
        out.printf("push %s %s\n", segment, index);
    }

    public void writePop(Segment segment, int index) {
        out.printf("pop %s %s\n", segment, index);
    }

    public void writeArithmetic(ArithmeticCommand command) {
        out.println(command);
    }

    public void writeCall(String name, int nArgs) {
        out.printf("call %s %s\n", name, nArgs);
    }

    public void writeFunction(String name, int nLocals) {
        out.printf("function %s %s\n", name, nLocals);
    }

    public void writeReturn() {
        out.println("return");
    }

}
