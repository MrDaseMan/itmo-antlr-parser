#include <stdio.h>
#include "parser.h"

int main(int argc, char *argv[]) {
	if (argc < 2) {
        fprintf(stderr, "Usage: %s <input file>\n", argv[0]);
        return 1;
    }

	const char *inputFileName = argv[1];

    ParseResult *result = parse_input(inputFileName, input);

    if (result->error_count > 0) {
        printf("Errors found:\n");
        for (int i = 0; i < result->error_count; i++) {
            printf("%s\n", result->error_messages[i]);
        }
    } else {
        printf("Parse successful. Root value: %s\n", result->root->value);
    }

    // Free allocated memory (implement the necessary cleanup functions)
    return 0;
}