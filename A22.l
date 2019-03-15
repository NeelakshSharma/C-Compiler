%{
#include <stdio.h>
extern int yylval;
%}

num	[0-9]

%%
{num}+	{yylval=atoi(yytext); return NUM;}
[\n]	{return 0;}
%%

int yywrap() {return 1;}
