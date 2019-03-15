%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *fp;
%}

%token INT FLOAT CHAR DOUBLE VOID
%token WHILE
%token PRINTF SCANF
%token SWITCH CASE BREAK
%token NUM ID
%token INCLUDE
%token DOT
%token MOD AMPERSAND

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT
%%
start:	Function {printf("syntax verified");}
	| Declaration {printf("Syntax Verified");}
	| error
	;

Declaration: Type Assignment ';'
	| Assignment ';'
	| FunctionCall ';'
	| Array ';'
	| Type Array ';'
	;

Assignment: ID '=' Assignment
	| ID '=' FunctionCall
	| ID '=' Array
	| Array '=' Assignment
	| ID ',' Assignment
	| NUM ',' Assignment
	| ID '+' Assignment
	| ID '-' Assignment
	| ID '*' Assignment
	| ID '/' Assignment
	| NUM '+' Assignment
	| NUM '-' Assignment
	| NUM '*' Assignment
	| NUM '/' Assignment
	| '\'' Assignment '\''
	| '(' Assignment ')'
	| '-' '(' Assignment ')'
	| '-' NUM
	| '-' ID
	|	NUM |	ID	;

FunctionCall :	ID'('')'
	| ID'('Assignment')'
	;

Array :	ID'['Assignment']'
	;

Function: Type ID '(' ArgListOpt ')' CompoundStatement
	;
ArgListOpt: ArgList
	|
	;
ArgList: ArgList ',' Arg
	| Arg
	;
Arg:	Type ID
	;
CompoundStatement:	'{' StatementList '}'
	;
StatementList:	StatementList Statement
	|
	;
Statement:	WhileStatement
	| Declaration
	| SwitchStatement
	| PrintFunc
	| ReadFunc
	| ';'
	;

Type:	INT
	| FLOAT
	| CHAR
	| DOUBLE
	| VOID
	;

WhileStatement:	WHILE '(' Expr ')' Statement
	| WHILE '(' Expr ')' CompoundStatement
	;

SwitchStatement : SWITCH '(' ID ')'
		'{'Cases'}'
	;

Cases : Case1|Case2
	;

Case1 : CASE NUM ':' Statement BREAK ';'
	| CASE NUM ':' Statement BREAK ';' Case1
	| CASE NUM ':' CompoundStatement BREAK ';'
	| CASE NUM ':' CompoundStatement BREAK ';' Case1
	;
	
Case2 : CASE ID ':' Statement BREAK ';'
	| CASE ID ':' Statement BREAK ';' Case2
	| CASE ID ':' CompoundStatement BREAK ';'
	| CASE ID ':' CompoundStatement BREAK ';' Case2
	;			

PrintFunc : PRINTF '(' Expr ')' ';'
	;

ReadFunc : SCANF '(' Expr ')' ';'
	;

Expr:
	| Expr LE Expr
	| Expr GE Expr
	| Expr EQ Expr
	| Expr GT Expr
	| Expr LT Expr
	| Expr NE Expr
	| Assignment
	| Array
	;
%%
#include"lex.yy.c"
#include<ctype.h>
int count=0;
int main(int argc,char *argv[])
{
	yyin=fopen(argv[1], "r");
	if(!yyparse())
	{
		printf("\nparsing complete\n");
	}
	else
	{
		printf("\nparsing failed\n");
	}
	fclose(yyin);
	return 0;
}
yyerror(char *s)
{
	printf("Error  :line no %d:  %s %s\n", yylineno,  s, yytext );
}


