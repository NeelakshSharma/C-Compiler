%{
extern int yylineno;
%}

letter	[a-zA-Z]
dig	[0-9]

%%
[%]	return MOD;
[&]	return AMPERSAND;
[ \t]	;
[ \n]	{ yylineno = yylineno + 1; }
void	return VOID;
int	return INT;
float	return FLOAT;
char	return CHAR;
double	return DOUBLE;
while	return WHILE;
switch	return SWITCH;
case	return CASE;
break	return BREAK;
printf	return PRINTF;
scanf	return SCANF;
^"#include ".+	;
{dig}+	return NUM;
{letter}({letter}|{dig})*	return ID;
"<="	return LE;
">="	return GE;
"=="	return EQ;
"!="	return NE;
">"	return GT;
"<"	return LT;
"."	return DOT;
\/\/.*	;
\/\*(.*\n)*.*\*\/	;
.	return yytext[0];
%%
