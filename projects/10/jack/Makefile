ANTLR4_JAR=/usr/local/lib/antlr-4.9.1-complete.jar
PLANT_UML_JAR=/usr/local/lib/plantuml.jar


build:
	mvn compile -T4

build-test:
	mvn test-compile -T4

clean:
	rm -rf src/main/generated-sources
	mvn clean -T4

test:
	mvn test -T4

run:
	mvn exec:java -Dexec.args=${main}

grun:
	@cd target/classes && java org.antlr.v4.gui.TestRig com.si0005hp.Jack program -gui

test_prj10:
	@cd target/classes && \
		find ../../../../10/ -name "*.jack" \
		| xargs -I{} java org.antlr.v4.gui.TestRig com.si0005hp.Jack program {} 

NO_PHONY = /^(z):/
.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ && !$(NO_PHONY) {print $$1}')
