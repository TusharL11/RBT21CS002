%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct symtab { char *name; };
struct symtab sym[10], *k;
struct symtab *install_id(char *s);
void disp();
%}

L [a-zA-Z]
D [0-9]
id {L}({L}|{D})*
num {D}+(\.{D}+)?([eE][-+]?{D}+)?
bop [-+*/=]
uop "++"|"--"
relop "<"|"<="|">"|">="|"!="|"=="
lop "&&"|"||"
bitlop [&|!]
kew "if"|"else"|"while"|"do"|"for"|"int"|"char"|"float"
pun [,;'"\[\]\{\}\)\(]
comment "/\*"(.|\n)*"\*/"|"//".*
ws [ \t\n]+
st \"(.)*\"

%%
{ws} {}
{kew} { printf("keyword = %s\n", yytext); }
{id} { k = install_id(yytext); printf("identifier = %s\n", yytext); }
{num} { printf("constant = %s\n", yytext); }
{bop} { printf("binary op = %s\n", yytext); }
{uop} { printf("unary op = %s\n", yytext); }
{relop} { printf("relational op = %s\n", yytext); }
{lop} { printf("logical op = %s\n", yytext); }
{pun} { printf("punctuation = %s\n", yytext); }
{bitlop} { printf("bitwise logical op = %s\n", yytext); }	
{comment} { printf("comment = %s\n", yytext); }
{st} { printf("string = %s\n", yytext); }
%%

int main() {
    yylex(); // Call the lexer
    disp(); // Display the symbol table
    return 0;
}

struct symtab *install_id(char *s) {
    for (struct symtab *p = sym; p < &sym[10]; p++) {
        if (p->name && !strcmp(s, p->name)) return p;
        if (!p->name) {
            p->name = strdup(s);
            if (!p->name) {
                fprintf(stderr, "Memory allocation failed\n");
                exit(1);
            }
            return p;
        }
    }
    fprintf(stderr, "Symbol table overflow\n");
    exit(1);
}

void disp() {
    printf("\nSymbol Table:\n");
    for (struct symtab *p = sym; p < &sym[10]; p++)
        if (p->name) printf("%s\n", p->name);
}

int yywrap() { return 1; }
