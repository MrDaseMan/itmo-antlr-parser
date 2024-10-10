lexer grammar lang;

options {
    language=C;
    backtrack=true;
}
IDENTIFIER // идентификатор
    : ('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '0'..'9' | '_')*; 

STRING // строка, окруженная двойными кавычками
    : '"' ( '\\' . | ~('\\'|'"') )* '"'
    ; 

CHAR // одиночный символ в одинарных кавычках
    : '\'' ~('\'' | '\\') '\''
    ;

HEX // шестнадцатеричный литерал
    : '0' ('x' | 'X') ('0'..'9' | 'A'..'F' | 'a'..'f')+
    ;

// bits: "0[bB][01]+"; // битовый литерал
BITS // битовый литерал
    : '0' ('b' | 'B') ('0' | '1')+
    ;

// dec: "[0-9]+"; // десятичный литерал
DEC // десятичный литерал
    : ('0'..'9')+
    ;

// bool: 'true'|'false'; // булевский литерал
BOOL // булевский литерал
    : 'true' | 'false'
    ;

// list<item>: (item (',' item)*)?; // список элементов, разделённых запятыми
ITEM: STRING | CHAR | HEX | BITS | DEC | BOOL | IDENTIFIER;

LIST // список элементов, разделённых запятыми
    : (ITEM (',' ITEM)*)?
    ;

BUILTIN_TYPE // встроенный тип
    : 'bool' | 'byte' | 'int' | 'uint' | 'long' | 'ulong' | 'char' | 'string'
    ;

CUSTOM_TYPE // пользовательский тип
    : IDENTIFIER
    ;

TYPE_REF
    : BUILTIN_TYPE | CUSTOM_TYPE | ARRAY_TYPE
    ;

ARRAY_TYPE // массив
    : 'array' '[' (',')* ']' 'of' TYPE_REF
    ;

BINOP // бинарный оператор
    : '+' | '-' | '*' | '/' | '%' | '<<' | '>>' | '&' | '|' | '^' | '&&' | '||' | '==' | '!=' | '<' | '>' | '<=' | '>=' | '+=' | '-=' | '*=' | '/=' | '%=' | '<<=' | '>>=' | '&=' | '|=' | '^='
    ;

UNOP // унарный оператор
    : '!' | '++' | '--'
    ;

// EXPR
//     : EXPR_BINARY
//     | EXPR_BRACES
//     | EXPR_CALL
//     | EXPR_INDEXER
//     | EXPR_PLACE
//     | EXPR_LITERAL
//     ;

// EXPR_BINARY
//     : EXPR_UNARY (BINOP EXPR)* // где binOp - символ бинарного оператора
//     ;

// EXPR_UNARY
//     : UNOP EXPR // где unOp - символ унарного оператора
//     ;

// EXPR_BRACES
//     : '(' EXPR ')'
//     ;

// EXPR_CALL
//     : EXPR '(' LIST<EXPR_ARG> ')'
//     ;
    
// EXPR_INDEXER
//     : EXPR '[' LIST<EXPR_ARG> ']'
//     ;

// EXPR_PLACE
//     : IDENTIFIER
//     ;

// EXPR_LITERAL
//     : STRING
//     | CHAR
//     | HEX
//     | BITS
//     | DEC
//     | BOOL
//     ;

EXPR
    : EXPR_PRIMARY EXPR_SUFFIX*
    ;

EXPR_PRIMARY
    : EXPR_BRACES
    | EXPR_PLACE
    | EXPR_LITERAL
    ;

EXPR_SUFFIX
    : EXPR_BINARY_SUFFIX
    | EXPR_CALL_SUFFIX
    | EXPR_INDEXER_SUFFIX
    ;

EXPR_BINARY_SUFFIX
    : BINOP EXPR_PRIMARY
    ;

EXPR_CALL_SUFFIX
    : '(' LIST<EXPR_ARG> ')'
    ;

EXPR_INDEXER_SUFFIX
    : '[' LIST<EXPR_ARG> ']'
    ;

EXPR_BRACES
    : '(' EXPR ')'
    ;

EXPR_UNARY
    : UNOP EXPR
    ;

EXPR_PLACE
    : IDENTIFIER
    ;

EXPR_LITERAL
    : STRING
    | CHAR
    | HEX
    | BITS
    | DEC
    | BOOL
    ;

STATEMENT
    : STATEMENT_IF
    | STATEMENT_BLOCK
    | STATEMENT_WHILE
    | STATEMENT_DO
    | STATEMENT_BREAK
    | STATEMENT_EXPRESSION
    ;

STATEMENT_IF
    : 'if' EXPR 'then' STATEMENT ('else' STATEMENT)?
    ;

STATEMENT_BLOCK
    : 'begin' STATEMENT* 'end' ';'
    ;

STATEMENT_WHILE
    : 'while' EXPR 'do' STATEMENT
    ;

STATEMENT_DO
    : 'repeat' STATEMENT ('while'|'until') EXPR ';'
    ;

STATEMENT_BREAK
    : 'break' ';'
    ;

STATEMENT_EXPRESSION
    : EXPR ';'
    ;

FUNC_BODY // тело функции
    : ('var' (LIST<IDENTIFIER> (':' TYPE_REF)? ';')*)? STATEMENT_BLOCK
    ;

FUNC_ARG_DEF // аргумент функции
    : IDENTIFIER (':' TYPE_REF)?
    ;

FUNC_SIGNATURE // сигнатура функции
    : IDENTIFIER '(' LIST<FUNC_ARG_DEF> ')' (':' TYPE_REF)?
    ;

FUNC_DEF // функция
    : 'method' FUNC_SIGNATURE (FUNC_BODY|';')
    ;

SOURCE_ITEM
    : FUNC_DEF
    ;

SOURCE
    : SOURCE_ITEM*
    ;