%{
#include<stdio.h>
%}

%token NUM

%left '+' '-'
%left '*' '/'

%%

lines: lines '\n'
    | lines exp '\n' { printf("ans = %lf\n", $2); }
    | /* empty */
    ;

exp: NUM             { $$ = $1; }
   | '(' exp ')'     { $$ = $2; }
   | exp '+' exp     { $$ = $1 + $3; }
   | exp '-' exp     { $$ = $1 - $3; }
   | exp '*' exp     { $$ = $1 * $3; }
   | exp '/' exp     { $$ = $1 / $3; }
   ;

%%

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}
