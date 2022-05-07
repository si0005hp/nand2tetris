package com.si0005hp;

import lombok.Value;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Stream;

public class SymbolTable {

    private final Map<Kind, Map<String, Symbol>> symbols = new LinkedHashMap<>() {{
        put(Kind.ARG, new HashMap<>());
        put(Kind.VAR, new HashMap<>());
        put(Kind.STATIC, new HashMap<>());
        put(Kind.FIELD, new HashMap<>());
    }};

    enum Kind {
        STATIC, FIELD, ARG, VAR
    }

    @Value
    static class Symbol {
        String name;
        String type;
        Kind kind;
        int index;
    }

    public void define(String name, String type, Kind kind) {
        tableOf(kind).put(name, new Symbol(name, type, kind, varCount(kind)));
    }

    public void startSubroutine() {
        Stream.of(Kind.ARG, Kind.VAR).map(this::tableOf).forEach(Map::clear);
    }

    public int varCount(Kind kind) {
        return tableOf(kind).size();
    }

    public Optional<Kind> kindOf(String name) {
        return lookup(name).map(Symbol::getKind);
    }

    public Optional<String> typeOf(String name) {
        return lookup(name).map(Symbol::getType);
    }

    public Optional<Integer> indexOf(String name) {
        return lookup(name).map(Symbol::getIndex);
    }

    public Optional<Symbol> lookup(String name) {
        for (var table : symbols.values()) {
            if (table.containsKey(name)) return Optional.of(table.get(name));
        }
        return Optional.empty();
    }

    private Map<String, Symbol> tableOf(Kind kind) {
        return symbols.get(kind);
    }

}
