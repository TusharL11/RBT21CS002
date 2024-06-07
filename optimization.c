#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct quad {
    char ope[5];
    char arg1[5];
    char arg2[5];
    char res[5];
} QUAD[5];

int n;

void get() {
    printf("\nEnter number of quadruples in a block: ");
    scanf("%d", &n);
    printf("Enter quadruples in the form (operator arg1 arg2 result):\n");
    for(int i = 0; i < n; i++)
        scanf("%s %s %s %s", QUAD[i].ope, QUAD[i].arg1, QUAD[i].arg2, QUAD[i].res);
}

void disp() {
    printf("\nQuadruples:\nOperator\tArg1\tArg2\tResult\n");
    for(int i = 0; i < n; i++)
        printf("%s\t\t%s\t%s\t%s\n", QUAD[i].ope, QUAD[i].arg1, QUAD[i].arg2, QUAD[i].res);
}

void const_folding() {
    for(int i = 0; i < n; i++) {
        int arg1_val = atoi(QUAD[i].arg1);
        int arg2_val = atoi(QUAD[i].arg2);
        int result = 0;
        
        if(strcmp(QUAD[i].ope, "+") == 0)
            result = arg1_val + arg2_val;
        else if(strcmp(QUAD[i].ope, "-") == 0)
            result = arg1_val - arg2_val;
        else if(strcmp(QUAD[i].ope, "*") == 0)
            result = arg1_val * arg2_val;
        else if(strcmp(QUAD[i].ope, "/") == 0)
            result = arg1_val / arg2_val;

        sprintf(QUAD[i].res, "%d", result);
        strcpy(QUAD[i].ope, "=");
        strcpy(QUAD[i].arg1, QUAD[i].res);
        strcpy(QUAD[i].arg2, "");
    }
}

void main() {
    get();
    printf("\nInitial Quadruples:\n");
    disp();
    const_folding();
    printf("\nQuadruples after constant folding optimization:\n");
    disp();
}
