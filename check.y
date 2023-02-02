%{
    //Faiyaj Bin Amin, Roll:1707062
    //Required function definitions and header files are mentioned here.
	
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	#include<time.h>
	#include<string.h>
	FILE *yyin, *yyout; // File pointers

	int yylex(void);
	void yyerror(char *s);
	
	int totVars = 0;		// This vars will keep track of the total variables used.
	
	//Edit Defining a structure to handle the properties of variables.
	struct varStruct{
		char varName[25];
        int varDataType;
        char *cval;
		int ival;
		float fval;
		
	}vars[100];
	
	// //X Function for searching if the present vars name has already been used.
	// int search_var(char name[25]){
	// 	int i;
	// 	for(i=0; i<totVars; i++){
	// 		if(!strcmp(vars[i].varName, name)){
	// 			return 1;
	// 		}
	// 	}
	// 	return 0;
	// }
	
	// Set data type of a vars
	void setDataType(int type){
		int i;
		for(i=0; i<totVars; i++){
			if(vars[i].varDataType == -1){
				vars[i].varDataType = type;
			}
		}
	}
	
	// Finind the index of any vars
	int get_var_index(char name[20]){
		int i;
		for(i=0; i<totVars; i++){
			if(!strcmp(vars[i].varName, name))  /// strcmp ret val 0 when strings equal
            {
				return i;
			}
		}
		return -1;
	}
	
%}

%union{
    char* varString;
	double var;
}

	//Grammar Rules Declarations in BNF form(CFG)

%error-verbose
%token MAIN INT CHAR FLOAT POWER FACTO PRIME READ PRINT IF ELIF ELSE SWITCH CASE DEFAULT FROM TO INC DEC MAX MIN ID NUM PLUS MINUS MUL DIV EQUAL NOTEQUAL GT GOE LT LOE
%left PLUS MINUS
%left MUL DIV

	// Mentioning type of token 
%type<varString> ID1 ID
%type<var>prime_code factorial_code casenum_code default_code case_code switch_code e f t expression else_if elsee bool_expression power_code min_code max_code declaration assignment condition for_code print_code read_code program code TYPE MAIN INT CHAR FLOAT POWER FACTO PRIME READ PRINT SWITCH CASE DEFAULT IF ELIF ELSE FROM TO INC DEC MAX MIN NUM PLUS MINUS MUL DIV EQUAL NOTEQUAL GT GOE LT LOE



    // Grammar Rules Declarations
%%

program: MAIN '{' code '}'	{printf("\nProgram Executed Successfully\n");
							printf("\nNo of variables--> %d", totVars);}
		;

code: declaration code
	| assignment code
	| condition code
	| for_code code
	| switch_code code
	| print_code code
	| read_code code
	| power_code code
	| factorial_code code
	| prime_code code
	| min_code code
	| max_code code
	|
	;

	// Power function
power_code: POWER '(' NUM ',' NUM ')'';'	{		
	int i;
	i = pow($3, $5);
	printf("\nPower value is %d ", i);
}
	;

	//CFG for calculating factorial of a number

factorial_code: FACTO '(' NUM ')' ';'	{
	int j = $3;
	int i, result;
	result = 1;
	if(j==0){
		printf("\nFactorial of %d is %d", j, result);
	}
	else{
		for(i = 1; i <= j; i++){
			result = result*i;
		}
		printf("\nFactorial of %d is %d", j, result);
	}
	
}
	;
	
	//CFG for checking if a number is prime or not
	
prime_code: PRIME '(' NUM ')' ';'{
	int n, i, flag = 0;
	n = $3;
	for (i = 2; i <= n / 2; ++i) {
		if (n % i == 0) {
			flag = 1;
			break;
		}
	}
    printf("\n%d", flag);

}
	;

	//CFG for max() funtion

max_code: MAX '(' ID ',' ID')'';'{
	int i = get_var_index($3);
	int j = get_var_index($5);
	int k,l;
	if((vars[i].varDataType == 1) &&(vars[j].varDataType == 1) ){
		k = vars[i].ival;
		l = vars[j].ival;
		if(l>k){
			printf("\nMax value is--> %d", l);
		}
		else{
			printf("\nMax value is--> %d", k);
		}
	}
	else if((vars[i].varDataType == 2) &&(vars[j].varDataType == 2) ){
		k = vars[i].fval;
		l = vars[j].fval;
		if(l>k){
			printf("\nMax value is--> %f", l);
		}
		else{
			printf("\nMax value is--> %f", k);
		}
	}
	else{
		printf("\nNot integer or float vars");
	}
}
	;
	
	//CFG for min() function
	
min_code: MIN '(' ID ',' ID')'';'{
	int i = get_var_index($3);
	int j = get_var_index($5);
	int k,l;
	if((vars[i].varDataType == 1) &&(vars[j].varDataType == 1) ){
		k = vars[i].ival;
		l = vars[j].ival;
		if(l<k){
			printf("\nMin value is--> %d", l);
		}
		else{
			printf("\nMin value is--> %d", k);
		}
	}
	else if((vars[i].varDataType == 2) &&(vars[j].varDataType == 2) ){
		k = vars[i].fval;
		l = vars[j].fval;
		if(l<k){
			printf("\nMin value is--> %f", l);
		}
		else{
			printf("\nMin value is--> %f", k);
		}
	}
	else{
		printf("\nNot integer or float vars");
	}
}
	;
	
	//CFG for print() function
	
print_code: PRINT '(' ID ')'';'{
	int i = get_var_index($3);
	if(vars[i].varDataType == 1){
		printf("\nVariable name--> %s, Value--> %d", vars[i].varName, vars[i].ival);
	}
	else if(vars[i].varDataType == 2){
		printf("\nVariable name--> %s, Value--> %f", vars[i].varName, vars[i].fval);
	}
	else{
		printf("\nVariable name--> %s, Value--> %c", vars[i].varName, vars[i].cval);
	}
}
	;
	
	//CFG for read() funtion
	
read_code: READ'(' ID ')'';'{
	int i = get_var_index($3);
	printf("\nRead command found for variabale--> %s, but no further implementaion\n",vars[i].varName);
}
	;
	
	// CFG for from-to loop (For Loop)

switch_code: SWITCH '(' ID ')' '{' case_code '}' {
	printf("\nSwitch-case structure detected.");
}
	;
case_code: casenum_code default_code
	;

casenum_code: CASE NUM '{' code '}' casenum_code {
	printf("\nCase no--> %d", $2);
}
	|
	;
default_code: DEFAULT '{' code '}'
	;


for_code: FROM ID TO NUM INC NUM '{' code '}' {
	printf("\nFor loop detected");
	int ii = get_var_index($2);
	int i = vars[ii].ival;
	int j = $4;
	int inc = $6;
	int k;
	for(k=i; k<j; k=k+inc){
		printf("\nFrom-To Loop running-->");
	}
		
}
		| FROM ID TO NUM DEC NUM '{' code '}'{
	printf("\nFor loop detected");
	int ii = get_var_index($2);
	int i = vars[ii].ival;
	int j = $4;
	int dec = $6;
	int k;
	for(k=i; k<j; k=k-dec){
		printf("\nFrom-To Loop running-->");
	}
}
	;
	
	//CFG for while loop
	/*
while_code: WHILE'(' bool_expression ')''{' code '}'{
	printf("\nwhile loop detected\n");
	int i = $3;
	while(i==1){
		printf("\nWhile Loop running--> %d", $6);
	}
	
}
	;
	*/
	//CFG for if-elif-else structure
	
condition: IF'(' bool_expression ')''{'code'}' else_if elsee {
	printf("\nIF condition detected");
	int i = $3;
	if(i==1){
		printf("\nIF condition is true");
	}
	else{
		printf("\nIF condition false");
	}
}
	;
else_if: ELIF '(' bool_expression ')''{' code '}' else_if {
	printf("\nELIF condition detected");
	int i = $3;
	if(i==1){
		printf("\nELIF condition true");
	}
	else{
		printf("\nELIF condition false");
	}
}
		|
	;
elsee: ELSE '{' code '}' {
	printf("\nELSE condition is detected");
}
	|
	;
	
	//CFG for evaluating boolian expression

bool_expression: expression EQUAL expression {
	if($1==$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
				| expression NOTEQUAL expression {
	if($1!=$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
				| expression GT expression {
	if($1>$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
				| expression GOE expression {
	if($1>=$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
				| expression LT expression {
	if($1<$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
				| expression LOE expression {
	if($1<=$3){
		$$ = 1;
	}
	else{
		$$ = 0;
	}
}
	;

	// Variable declarations
declaration: TYPE ID1 ';' {
	setDataType($1);
}
	;

TYPE: CHAR	{$$ = 0; printf("\nCharacter Variable");}
	| FLOAT	{$$ = 2; printf("\nFloat Variable");}
    | INT	{$$ = 1; printf("\nInteger Variable");}
	;

ID1: ID1 ',' ID {
		strcpy(vars[totVars].varName, $3);
		printf("\nThe vars is %s", $3);
		vars[totVars].varDataType =  -1;
		totVars = totVars + 1;
	}
	| ID {
		strcpy(vars[totVars].varName, $1);
		printf("\nThe vars is %s", $1);
		vars[totVars].varDataType =  -1;
		totVars = totVars + 1;
	strcpy($$, $1); /// edit
    }
	;
	
	// Value Assignment
assignment: ID '=' expression ';' {
	$$ = $3;
		int i = get_var_index($1);
		if(vars[i].varDataType==0){
			vars[i].cval = (char*)&$3;
			printf("\nThe vars is %s", vars[i].cval);
		}
		else if(vars[i].varDataType==1){
			vars[i].ival = $3;
			printf("\nThe vars is %d", vars[i].ival);
		}
		else if(vars[i].varDataType==2){
			vars[i].fval = (float)$3;
			printf("\nThe vars is %f", vars[i].fval);
		}
    }
	;

expression: e {$$ = $1;}
	;
e: e PLUS f {$$ = $1 + $3; }
	| e MINUS f {$$ = $1 - $3;}
	| f      {$$ = $1;}
	;
f: f MUL t {$$ = $1 * $3;}
	| f DIV t 
	{if($3 != 0)
	{
		$$ = $1 / $3;
	}
	else{
		printf("\nLogical Error");
	}
}
	| t   {$$ = $1;}
	;
t: '(' e ')' {$$ = $2;}
	| ID {
	int id_index = get_var_index($1);
	if(id_index == -1)
	{
		yyerror("Invalid vars mentioned");
	}
	else
	{
		if(vars[id_index].varDataType == 1)
		{
			$$ = vars[id_index].ival;
		}
		else if(vars[id_index].varDataType == 2)
		{
			$$ = vars[id_index].fval;
		}
	}
}
	| NUM  {$$ = $1;}
	;

%%



    // C codes
void yyerror(char *s)
{
	fprintf(stderr, "\n%s", s);
}

int main(){

	yyin = fopen("input.txt", "r"); /// taking input
	yyout = freopen("output.txt", "w", stdout); // output in file
	yyparse();
	return 0;
}