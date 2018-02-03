grammar Pseudo;


program
    : (algorithm | expression)+
    ;

algorithm
    : ALGORITHM IDENTIFIER '(' parameters '):' (IDENTIFIER ':')? (returnExpression | expression)* '.'
    ;

parameters
    : parameterDeclaration (',' parameterDeclaration)*
    |
    ;
    
parameterDeclaration
    : IDENTIFIER IDENTIFIER
    ;

arguments
    : expression (',' expression)*
    |
    ;

returnExpression
    : RETURN expression
    | RETURN
    ;

expression
    : term ((PLUS | MINUS) term)*
    ;

term
    : scalar ((TIMES | DIVIDED | MODULO) scalar)*
    ;

scalar
    : NUMBER
    | IDENTIFIER
    | functionCall
    ;

functionCall
    : IDENTIFIER '(' arguments ')'
    ;


// Arithmentic Tokens

PLUS        : '+';

MINUS       : '-';

TIMES       : '*';

DIVIDED     : 'div';

MODULO      : 'mod';

// Keyword Tokens
    
ALGORITHM   : 'algorithm';

RETURN      : 'return';

// Literal Tokens

NUMBER      : [0-9]+;

IDENTIFIER  : [a-zA-Z]+;

// Whitespace and Comment Tokens

COMMENT     : '#' ~[\r\n]* -> skip;

WHITESPACE  : [ \t\r\n]+ -> skip;
