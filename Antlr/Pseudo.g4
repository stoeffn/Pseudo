grammar Pseudo;

// ##########################################
// ##                PARSER                ##
// ##########################################

// Program

program
    : blockList
    ;

// Statements

statement
    : BREAK
    | CONTINUE
    | RETURN expression?
    | declaration
    | expression
    | assignment
    ;

statementList
    : statement (SEMICOLON statement?)*
    ;

block
    : statementList
    | algorithm
    | condition
    | loop
    ;

blockList
    : block*
    ;

condition
    : IF expression THEN blockList (ELSE blockList)? POINT
    ;

loop
    : WHILE expression DO blockList POINT
    | REPEAT blockList UNTIL expression POINT
    | FOR parameter IN expression DO blockList POINT
    | FOR (declaration | assignment) TO expression DO blockList POINT
    | FOR (declaration | assignment) DOWNTO expression DO blockList POINT
    ;

declaration
    : parameter
    | parameter ASSIGN expression
    ;

assignment
    : scalar ASSIGN expression
    ;

// Algorithms

algorithm
    : ALGORITHM (IDENTIFIER POINT)? IDENTIFIER parameterList COLON returnType? blockList POINT
    ;

parameterList
    : OPENING_PARENTHESIS parameter (COMMA parameter)* CLOSING_PARENTHESIS
    | OPENING_PARENTHESIS CLOSING_PARENTHESIS
    ;
    
parameter
    : IDENTIFIER IDENTIFIER
    | IDENTIFIER subscriptCall IDENTIFIER
    ;

returnType
    : IDENTIFIER COLON
    ;

arguments
    : expression (COMMA expression)*
    ;

// Expressions

expression
    : term ((PLUS | MINUS) term)*
    | NOT expression
    | expression relationOperator expression
    ;

term
    : scalar (arithmeticOperator scalar)*
    ;

arithmeticOperator
    : TIMES
    | DIVIDED
    | DIVIDED_AS_INTEGER
    | MODULO
    ;

relationOperator
    : EQUALS
    | NOT_EQUALS
    | GREATER_THAN
    | GREATER_THAN_OR_EQUALS
    | LESS_THAN
    | LESS_THAN_OR_EQUALS
    ;

scalar
    : NULL
    | TRUE
    | FALSE
    | NUMBER
    | STRING
    | OPENING_PARENTHESIS expression CLOSING_PARENTHESIS
    | anyCall
    ;

anyCall
    : functionCall anyCallExtension?
    | constructorCall anyCallExtension?
    | IDENTIFIER anyCallExtension?
    ;

anyCallExtension
    : POINT functionCall anyCallExtension?
    | subscriptCall anyCallExtension?
    ;

subscriptCall
    : OPENING_BRACKET expression CLOSING_BRACKET
    ;

functionCall
    : IDENTIFIER OPENING_PARENTHESIS arguments? CLOSING_PARENTHESIS
    ;

constructorCall
    : NEW functionCall
    ;

// ##########################################
// ##                LEXER                 ##
// ##########################################

// Delimiter Tokens

COMMA       : ',';
COLON       : ':';
SEMICOLON   : ';';

// Scope Tokens

POINT               : '.';
OPENING_PARENTHESIS : '(';
CLOSING_PARENTHESIS : ')';
OPENING_BRACKET     : '[';
CLOSING_BRACKET     : ']';

// Arithmetic Tokens

PLUS                : '+';
MINUS               : '-';
TIMES               : '*';
DIVIDED             : '/';
DIVIDED_AS_INTEGER  : 'div';
MODULO              : 'mod';

// Relationship Operators

EQUALS                  : '=';
NOT_EQUALS              : '≠';
GREATER_THAN            : '>';
GREATER_THAN_OR_EQUALS  : '≧';
LESS_THAN               : '<';
LESS_THAN_OR_EQUALS     : '≦';

// Assignment Tokens

ASSIGN  : '←';

// Expression Tokens

NOT : 'not';

// Condition Tokens

IF      : 'if';
THEN    : 'then';
ELSE    : 'else';

// Loop Tokens

FOR         : 'for';
IN          : 'in';
TO          : 'to';
DOWNTO      : 'downto';
DO          : 'do';
WHILE       : 'while';
REPEAT      : 'repeat';
UNTIL       : 'until';
BREAK       : 'break';
CONTINUE    : 'continue';

// Algorithm Tokens
    
ALGORITHM   : 'algorithm';
RETURN      : 'return';

// Object Tokens

NEW : 'new';

// Literal Tokens

NULL        : 'null';
TRUE        : 'true';
FALSE       : 'false';
IDENTIFIER  : [a-zA-Z] [a-zA-Z0-9]*;
NUMBER      : MINUS? [0-9]+;
STRING      : '"' ('\\"' | .)*? '"';

// Whitespace and Comment Tokens

COMMENT     : '//' ~[\r\n]* -> skip;
WHITESPACE  : [ \t\r\n]+ -> skip;
