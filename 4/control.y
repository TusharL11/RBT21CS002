%{
#include <stdio.h>
%}
%token id NUM OR AND NOT relop TRUE FALSE INC DEC IF ELSE DO WHILE uminus FOR SWITCH CASE BREAK DEFAULT
%right '='
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc uminus
%left OR
%left AND
%nonassoc NOT
%%
S1 : S1 S | S;
S : AS ';' | IFS | IFES | WS | DWS | FORS | SS;
SS : SWITCH'('E')''{' CV '}';
CV : CASE E ':' S1 BREAK ';' | CASE E ':' S1 BREAK ';' CV | CASE E ':' S1 BREAK ';' DEFAULT ':' S1;
AS : id '=' E;
E : E'+'E | E'-'E | E'*'E | E'/'E | E'^'E | '-' E %prec uminus | id | NUM;
IFS: IF'('BE')''{'S1'}';
BE : BE OR BE | BE AND BE | NOT BE |id relop id | TRUE | FALSE;
IFES : IF'('BE')''{'S1'}'ELSE'{'S1'}';
WS : WHILE '('BE')''{'S1'}';
DWS : DO '{'S1'}'WHILE'('BE')'';';
FORS : FOR'('IS';'BE';'MS')''{'S1'}';
IS : AS | IS ',' AS;
MS : IS | id INC | INC id | id DEC | DEC id;
%%
void main() { yyparse(); }
int yyerror(char *msg) { printf("%s\n",msg); }
