%{
     //Faiyaj Bin Amin, Roll:1707062
	//Required function definitions and header files are mentioned here.
	#include<stdio.h>
    #include<string.h>
	#include<stdlib.h>
	#include "mp1.tab.h"

	extern char* strdup(const char*);
	void yyerror(char *s);
%}

	// Definition of variables to reduce verbosity
HEADER	"bring"[ ]+[^\n]+[.h][ ]*
ID	[a-zA-Z][a-zA-Z0-9]*
NUMBER	[-]?[0-9][0-9]*[.]?[0-9]*

%%

    // Keyword detection
[ \t]+
"begin()" return(MAIN);
"int"	return(INT);
"char"	return(CHAR);
"float"	return(FLOAT);
"ladder"	return(SWITCH);
"exp"	return(POW);
"random" return(RANDOM);
"read"	return(SCAN);
"keepgoing" return(WHILE);
"sin" return(SIN);
"cos" return(COS);
"tan" return(TAN);
"log10" return(LOG10);
"fact"	 return(FACTOR);
"isprime"	return(ISPRIME);
"show"	return(OUTPUT);
"case"	return(CASE);
"bydefault"	return(DEFAULT);
"if"	return(IF);
"elif"	return(ELIF);
"nothingmatches"	return(ELSE);
"repeat"	return(REPEAT);
"to"	return(TO);
"++"	return(INC);
"--"	return(DEC);
"maxi"	return(MAX);
"mini"	return(MIN);
">"		return(GT);
">="	return(GOE);
"<"		return(LT);
"<="	return(LOE);
"+"		return(PLUS);
"-"		return(MINUS);
"*"		return(MULTI);
"/"		return(DIVI);
"=="	return(EQUALS);
"!="	return(NOTEQUAL);

{HEADER}	printf("Header file has been imported.\n");
{ID}	{yylval.varString = strdup(yytext); return(ID);}
{NUMBER}	{	int len = strlen(yytext);
			int i = 0;
			while(i<len){
				if(yytext[i]=='.'){
					yylval.var = atof(yytext); 
					return(NUM);
				}
				i++;
			}
			yylval.var = atoi(yytext); 
			return(NUM);
		}
[=,;{}()_^]	{yylval.varString = strdup(yytext); return *yytext;}
.		yyerror("Error! Invalid character inserted");
[##].*	printf("\n One Line comment here\n");
[\n]	{}

%% 
    // My subroutines
int yywrap(void){
	return 1;
}