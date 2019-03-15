%{
#include <stdio.h>
#include <stdlib.h>
int avg1=0,avg2=0,max1=0,max2=0;
%}
%token NUM

%%
statement: L T {if(avg1>20 && avg2>20) printf("Congratulations\n"); else printf("Sorry, Better luck next time\n");}
	;
L: NUM NUM {avg1=($1+$2)/2;}
	;
T: T1 {avg2=(max1+max2)/2; printf("\nbest of 3 selected are %d and %d\n",max1,max2);}
	;
T1: NUM NUM NUM { if($1>$2 || $1>$3) {max1=$1; if($2>$3) max2=$2; else max2=$3;} else {max1=$2; max2=$3;} }
	;
%%
#include"lex.yy.c"
#include<ctype.h>
void yyerror()
{
	printf("error");	
	exit(0);
}
int main()
{
	printf("enter the marks\n");
	yyparse();
	return 0;
}


