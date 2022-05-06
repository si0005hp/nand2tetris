grammar Jack;

program: classDec EOF;

classDec: CLASS className '{' classVarDec* subroutineDec* '}';

classVarDec: ('static' | 'field') type varName (',' varName)* ';';

type: INT | CHAR | BOOLEAN | className;

subroutineDec: (CONSTRUCTOR | FUNCTION | METHOD) (VOID | type) subroutineName '(' parameterList ')'
               subroutineBody;

parameterList: ((type varName) (',' type varName)*)?;

subroutineBody: '{' varDec* statements '}';

varDec: VAR type varName (',' varName)* ';';

className: IDENTIFIER;
subroutineName: IDENTIFIER;
varName: IDENTIFIER;

/* Statement */
statements : statement*;
statement: letStatement | ifStatement | whileStatement | doStatement | returnStatement;
letStatement: LET lhs = varName ('[' subscriptArg = expression ']')? '=' rhs = expression ';';
ifStatement: IF '(' expression ')' '{' thenBlock = statements '}' (ELSE '{' elseBlock = statements '}')?;
whileStatement: WHILE '(' expression ')' '{' statements '}';
doStatement: DO subroutineCall ';';
returnStatement: RETURN expression? ';';

/* Expression */
expression: term (op term)*;
// x + (y + z) * 10

term
    : INT_CONSTANT                  #Int
    | STRING_CONSTANT               #String
    | keywordConstant               #Keyword
    | varName                       #VarRef
    | varName '[' subscriptArg = expression ']'    #Subscript
    | subroutineCall                #Call
    | '(' expression ')'            #Grouping
    | unaryOp term                  #Unary
    ;

subroutineCall: subroutineName '(' expressionList ')'
              | (receiver = className | varName) '.' subroutineName  '(' expressionList ')';

expressionList: (expression (',' expression)*)?;

op: '+' | '-' | '*' | '/' | '&' | '|' | '<' | '>' | '=';
unaryOp: '-' | '~';

keywordConstant: TRUE | FALSE | NULL | THIS;

/*** Tokenizer ***/

/* comments */
MultiLineComment: '/*' .*? '*/' -> channel(HIDDEN);
SingleLineComment: '//' ~[\r\n\u2028\u2029]* -> channel(HIDDEN);

WS: [ \t\u000C]+ -> channel(HIDDEN);
LT: [\r\n]+ -> channel(HIDDEN);

/* keyword */
CLASS: 'class';
CONSTRUCTOR: 'constructor';
FUNCTION: 'function';
METHOD: 'method';
FIELD: 'field';
STATIC: 'static';
VAR: 'var';
INT: 'int';
CHAR: 'char';
BOOLEAN: 'boolean';
VOID: 'void';
TRUE: 'true';
FALSE: 'false';
NULL: 'null';
THIS: 'this';
LET: 'let';
DO: 'do';
IF: 'if';
ELSE: 'else';
WHILE: 'while';
RETURN: 'return';

/* Literal */
INT_CONSTANT: Digit+;
STRING_CONSTANT: '"' ~('\\' | '"')* '"';
IDENTIFIER: Alpha (Alpha | Digit)*;
fragment Digit: [0-9];
fragment Alpha: [a-zA-Z_];
