%{
# include<stdio.h>
int lc=0,tc=0,sc=0,wc=0,cc=0;
%}
%%
[^ \t\n]+ {cc+=yyleng; wc++;}
[ ] {cc++;sc++;}
[\t] {cc++; tc++;}
\n {cc++; lc++;}
%%
main()
{
yyin = fopen("a1.txt","r");
yyout=fopen("a2.txt","w");
yylex();
fclose(yyin);
fclose(yyout);
}
int yywrap()
{
fprintf(yyout,"no. of lines =%d\n",lc);
fprintf(yyout,"no. of tabs=%d\n",tc);
fprintf(yyout,"no. of characters = %d\n",cc);
fprintf(yyout,"no. of spaces = %d\n",sc);
fprintf(yyout,"no. of words=%d\n",wc);
return 1;
}
