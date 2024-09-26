lexer grammar lang;

IDENTIFIER: ('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '0'..'9' | '_')*; // идентификатор

// str: "\"[^\"\\]*(?:\\.[^\"\\]*)*\""; // строка, окруженная двойными кавычками

// char: "'[^\']'"; // одиночный символ в одинарных кавычках

// hex: (0[xX][0-9A-Fa-f]+); // шестнадцатеричный литерал

// bits: "0[bB][01]+"; // битовый литерал

// dec: "[0-9]+"; // десятичный литерал

// bool: 'true'|'false'; // булевский литерал

// list<item>: (item (',' item)*)?; // список элементов, разделённых запятыми

// source: sourceItem*;

// typeRef: {
//     |builtin: 'bool'|'byte'|'int'|'uint'|'long'|'ulong'|'char'|'string';
//     |custom: identifier;
//     |array: 'array' '[' (',')* ']' 'of' typeRef;
// };

// funcSignature: identifier '(' list<argDef> ')' (':' typeRef)? {
//     argDef: identifier (':' typeRef)?;
// };

// sourceItem: {
//     |funcDef: 'method' funcSignature (body|';') {
//         body: ('var' (list<identifier> (':' typeRef)? ';')*)? statement.block;
//     };
// };

// statement: {
//     |if: 'if' expr 'then' statement ('else' statement)?;
//     |block: 'begin' statement* 'end' ';';
//     |while: 'while' expr 'do' statement;
//     |do: 'repeat' statement ('while'|'until') expr ';';
//     |break: 'break' ';';
//     |expression: expr ';';
// };

// expr: { // присваивание через ':='
//     |binary: expr binOp expr; // где binOp - символ бинарного оператора
//     |unary: unOp expr; // где unOp - символ унарного оператора
//     |braces: '(' expr ')';
//     |call: expr '(' list<expr> ')';
//     |indexer: expr '[' list<expr> ']';
//     |place: identifier;
//     |literal: bool|str|char|hex|bits|dec;
// };