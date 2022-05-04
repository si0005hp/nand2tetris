package com.si0005hp;

import com.google.common.io.Files;
import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.FileInputStream;
import java.io.IOException;

/**
 * Hello world!
 */
public class Main {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("[ERROR]: no input file");
            System.exit(1);
        }

        var inputFilePath = args[0];
        JackParser.ProgramContext program = null;
        try {
            program = parseFile(inputFilePath);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }

        var writer = new VMWriter(System.out);
        var parser = createParser(Files.getNameWithoutExtension(inputFilePath), writer);

        parser.visitProgram(program);
    }

    private static JackVisitor<Void> createParser(String className, VMWriter writer) {
        return System.getenv("DEBUG") == null ? new Compiler(className, writer) :
                new ParserDebugger();
    }

    public static JackParser.ProgramContext parseFile(String filePath) throws IOException {
        try (var is = new FileInputStream(filePath)) {
            var parser = new JackParser(new CommonTokenStream(new JackLexer
                    (CharStreams.fromStream(is))));
            parser.setErrorHandler(new BailErrorStrategy());
            return parser.program();
        }
    }
}
