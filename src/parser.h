// parser.h
#ifndef PARSER_H
#define PARSER_H

#include "structures.h"
#include "lang.h"

#include <antlr3.h>

// typedef struct langLexer *pLangLexer;
// typedef struct langParser *pLangParser;

ParseResult* parse_input(ParseResult *result, pANTLR3_INPUT_STREAM *input);

#endif // PARSER_H