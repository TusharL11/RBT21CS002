%{
#include<stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%
"+"    { return '+'; }
"-"    { return '-'; }
"*"    { return '*'; }
"/"    { return '/'; }
"("    { return '('; }
")"    { return ')'; }
[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)? { yylval.v = atof(yytext); return NUM; }
\n     { return '\n'; }
[ \t]  ; /* skip whitespace */
.      { fprintf(stderr, "Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
