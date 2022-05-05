package com.si0005hp;

import lombok.RequiredArgsConstructor;

import java.io.Writer;

@RequiredArgsConstructor
public class VMWriter {

    private final Writer out;

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
        write("push %s %s", segment, index);
    }

    public void writePop(Segment segment, int index) {
        write("pop %s %s", segment, index);
    }

    public void writeArithmetic(ArithmeticCommand command) {
        write(command);
    }

    public void writeCall(String name, int nArgs) {
        write("call %s %s", name, nArgs);
    }

    public void writeFunction(String name, int nLocals) {
        write("function %s %s", name, nLocals);
    }

    public void writeReturn() {
        write("return");
    }

    private void write(String format, Object... args) {
        write(String.format(format, args));
    }

    private void write(Object s) {
        try {
            out.write(s.toString());
            out.write(System.lineSeparator());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
