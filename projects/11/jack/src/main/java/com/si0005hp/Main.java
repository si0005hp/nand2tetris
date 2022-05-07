package com.si0005hp;

import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.*;
import java.util.stream.Stream;

/**
 * Hello world!
 */
public class Main {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("[ERROR]: no input file");
            System.exit(1);
        }

        var file = new File(args[0]);
        if (!file.exists()) {
            System.err.printf("[ERROR]: No such file: %s\n", args[0]);
            System.exit(1);
        }

        if (file.isDirectory()) {
            Stream.of(file.listFiles((_d, name) -> name.endsWith(".jack"))).forEach(Main::compileFile);
        } else {
            compileFile(file);
        }
    }

    private static void compileFile(File file) {
        try (var bw = new BufferedWriter(new PrintWriter(new FileOutputStream(outputPath(file))))) {
            var program = parseFile(file);

            var writer = new VMWriter(bw);
            var compiler = newCompiler(file, writer);

            compiler.visitProgram(program);
        } catch (Exception e) {
            System.err.printf("[ERROR]: Compiler error: %s\n", file.getPath());
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static JackVisitor<Void> newCompiler(File file, VMWriter writer) {
        return System.getenv("DEBUG") == null ? new Compiler(file, writer) :
                new ParserDebugger();
    }

    public static JackParser.ProgramContext parseFile(File file) throws IOException {
        try (var is = new FileInputStream(file)) {
            var parser =
                    new JackParser(new CommonTokenStream(new JackLexer(CharStreams.fromStream(is))));
            parser.setErrorHandler(new BailErrorStrategy());
            return parser.program();
        }
    }

    private static String outputPath(File inputFile) {
        return inputFile.getPath().replaceAll(".jack$", ".vm");
    }
}
