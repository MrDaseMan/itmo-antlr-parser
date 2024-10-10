// structures.h
#ifndef STRUCTURES_H
#define STRUCTURES_H

typedef struct TreeNode {
    char *value;
    struct TreeNode **children;
    int children_count;
} TreeNode;

typedef struct ParseResult {
    TreeNode *root;
    char **error_messages;
    int error_count;
} ParseResult;

#endif // STRUCTURES_H