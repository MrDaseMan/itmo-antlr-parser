// parser.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "structures.h"
#include "parser.h"

// Read input file
pANTLR3_INPUT_STREAM open_input_file(const char *filename) {
    pANTLR3_INPUT_STREAM input = antlr3FileStreamNew((pANTLR3_UINT8)filename, ANTLR3_ENC_8BIT);
	if (input == NULL) {
        fprintf(stderr, "Failed to open input file: %s\n", filename);
        return NULL;
    }

    return input;
}

// Initialize the lexer
pLangLexer init_lexer(pANTLR3_INPUT_STREAM input) {
    pLangLexer lexer = LangLexerNew(input);
    if (lexer == NULL) {
        fprintf(stderr, "Failed to create lexer\n");
        return NULL;
    }
    return lexer;
}

// Initialize token stream
pANTLR3_COMMON_TOKEN_STREAM init_token_stream(pLangLexer lexer) {
    pANTLR3_COMMON_TOKEN_STREAM tokenStream = antlr3CommonTokenStreamSourceNew(ANTLR3_SIZE_HINT, TOKENSOURCE(lexer));
    if (tokenStream == NULL) {
        fprintf(stderr, "Failed to create token stream\n");
        return NULL;
    }
    return tokenStream;
}


// // Helper function to create a new TreeNode
// TreeNode* create_node(const char *value) {
//     TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
//     node->value = strdup(value);
//     node->children = NULL;
//     node->children_count = 0;
//     return node;
// }

// // Function to create a parse tree (stub implementation)
// TreeNode* build_parse_tree(ParseResult *result, pANTLR3_INPUT_STREAM *input) {
//     // Initialize the lexer with the input
//     pLangLexer lexer = LangLexerNew(input);
//     pANTLR3_COMMON_TOKEN_STREAM tokenStream;
//     pLangParser parser;

//     // Check if the lexer is valid
//     if (lexer->pLexer->)

//     pANTLR3_INPUT_STREAM inputStream = antlr3StringStreamNew((pANTLR3_UINT8)input, ANTLR3_ENC_8BIT, strlen(input), (pANTLR3_UINT8)"input");

//     // Create a token stream from the lexer
//     pANTLR3_COMMON_TOKEN_STREAM tokenStream = antlr3CommonTokenStreamSourceNew(ANTLR3_SIZE_HINT, TOKENSOURCE(lexer));

//     // Initialize the parser with the token stream
//     pLangParser parser = LangParserNew(tokenStream);

//     // Call the start rule of your grammar (replace 'startRule' with your actual start rule function)
//     LangParser_startRule_return result = parser->startRule(parser);

//     // Convert the result to your TreeNode structure
//     TreeNode *root = create_node("root");
//     // You need to implement the conversion based on your grammar and parse tree structure

//     // Clean up
//     parser->free(parser);
//     tokenStream->free(tokenStream);
//     lexer->free(lexer);
//     inputStream->close(inputStream);

//     // Return the root node
//     return root;
// }

// // Function to handle errors (stub implementation)
// void collect_errors(ParseResult *result) {
//     // Implement this function to collect error messages during parsing
//     result->error_count = 0;  // Update the error count
// }

// // Main function to parse input
// ParseResult* parse_input(ParseResult *result, pANTLR3_INPUT_STREAM *input) {
//     ParseResult *result = (ParseResult *)malloc(sizeof(ParseResult));
//     result->root = build_parse_tree(result, input);
//     result->error_messages = NULL;
//     result->error_count = 0;
//     collect_errors(result);
//     return result;
// }