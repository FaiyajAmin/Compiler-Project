%{
	
    //Faiyaj Bin Amin, Roll:1707062
    //Required function definitions and header files are mentioned here.
	
	#include<stdio.h>
	#include<stdlib.h>
    #include<time.h>
	#include<math.h>
	#include<string.h>
	FILE *yyin, *yyout; // File pointers

	int yylex(void);
	void yyerror(char *s);

    int totVars=0;
	//C Struct containing info about variables
	struct varStruct{
		char varName[25];
        char *cvar;
		int ivar;
		float fvar;
        int varDataType;
	}vars[50];   

	// Set data type of a var
	void setDataType(int type){
		int i;
		for(i=0; i<totVars; i++){
			if(vars[i].varDataType == -9){
				vars[i].varDataType = type;
			}
		}
	}

 //Finding index of a given variable
    int findVarIndex(char name[25]){
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

	//Mentioning tokens and associativity

%error-verbose
%token MAIN INT CHAR FLOAT POW RANDOM SCAN IF ELIF ELSE WHILE SIN COS TAN LOG10 FACTOR ISPRIME OUTPUT  SWITCH CASE DEFAULT REPEAT TO INC DEC MAX MIN ID NUM PLUS MINUS MULTI DIVI EQUALS NOTEQUAL GT GOE LT LOE
%left PLUS MINUS
%left MULTI DIVI

	// Mentioning type of token 
%type<varString> ID1 ID
%type<var>whileFunc factorialFunc caseNumber primeFunc defaultOption switchCase e expression elif lastElse boolianExpr powerFunc randFunc minFunc maxFunc declaration assignation condition forLoop printFunc scanFunc program statements TYPE MAIN INT CHAR FLOAT POW RANDOM SCAN WHILE SIN COS TAN LOG10 FACTOR ISPRIME  OUTPUT SWITCH CASE DEFAULT IF ELIF ELSE REPEAT TO INC DEC MAX MIN NUM PLUS MINUS MULTI DIVI EQUALS NOTEQUAL GT GOE LT LOE


    // Grammar Rules Declarations
%%

program: MAIN '{' statements '}'	{printf("\nProgram Executed Successfully\n");}
		;

statements:
    | declaration statements
	| assignation statements
	| condition statements
	| forLoop statements
	| switchCase statements
	| printFunc statements
	| scanFunc statements
	| whileFunc statements
	| powerFunc statements
	| randFunc statements
	| factorialFunc statements
	| primeFunc statements
	| minFunc statements
	| maxFunc statements
	;


randFunc: RANDOM '(' NUM ',' NUM ')'';'	{		
    srand(time(NULL));
	int x = rand();
	printf("\nRandom value is %d ", x);
    }
;   

	//Factorial for a given number
factorialFunc: FACTOR '(' NUM ')' ';'	{
	int j=$3, fact = 1;
	if(j==0){
		printf("\nFactorial of %d is %d", j, fact);
	}
	else{
        int i;
		for(i = 1; i <= j; i++){
			fact = fact*i;
		}
		printf("\nFactorial of %d is %d", j, fact);
	}
	
}
	;

    	// Power function
    powerFunc: POW '(' NUM ',' NUM ')'';'	{		
	int x = pow($3, $5);
	printf("\nPower value is %d ", x);
    }
;
	
	//Checking if a number is prime or not

primeFunc: ISPRIME '(' NUM ')' ';'  {
	int i, fl = 0;
	int n = $3;
	for (i = 2; i <=n-1; i++) {
		if (n % i == 0) {
			fl = 1;
			break;
		}
	}
    if(fl)
        printf("\nThe number %d is not prime\n", n);
    else
        printf("\nThe number %d is prime\n", n);

    }
    ;

	//Show() function to output something
printFunc: OUTPUT '(' ID ')'';'{
	int i = findVarIndex($3);
	if(vars[i].varDataType == 1){
		printf("\n %s has value %d", vars[i].varName, vars[i].ivar);
	}
	else if(vars[i].varDataType == 2){
		printf("\n%s has value %f", vars[i].varName, vars[i].fvar);
	}
	else if(vars[i].varDataType == 0){
		printf("\n%s has value %c", vars[i].varName, vars[i].cvar);
	}
}
	;


	//Maximum of two values
maxFunc: MAX '(' ID ',' ID')'';'{
	int i = findVarIndex($3);
	int j = findVarIndex($5);
	int k,l;
	if((vars[i].varDataType == 1) &&(vars[j].varDataType == 1) ){
		k = vars[i].ivar;
		l = vars[j].ivar;
		if(l>k){
			printf("\nMaximum value is %d", l);
		}
		else{
			printf("\nMaximum value is %d", k);
		}
	}
	else if((vars[i].varDataType == 2) &&(vars[j].varDataType == 2) ){
		k = vars[i].fvar;
		l = vars[j].fvar;
		if(l>k){
			printf("\nMaximum value is %f", l);
		}
		else{
			printf("\nMaximum value is %f", k);
		}
	}
	else{
		printf("\nThe values can not be compared");
	}
}
	;
	
	//Minimum of two values
minFunc: MIN '(' ID ',' ID')'';'{
	int i = findVarIndex($3);
	int j = findVarIndex($5);
	int k,l;
	if((vars[i].varDataType == 1) &&(vars[j].varDataType == 1) ){
		k = vars[i].ivar;
		l = vars[j].ivar;
		if(l<k){
			printf("\nMinimum value is %d", l);
		}
		else{
			printf("\nMinimum value is %d", k);
		}
	}
	else if((vars[i].varDataType == 2) &&(vars[j].varDataType == 2) ){
		k = vars[i].fvar;
		l = vars[j].fvar;
		if(l<k){
			printf("\nMinimum value is %f", l);
		}
		else{
			printf("\nMinimum value is %f", k);
		}
	}
	else{
		printf("\nThe values can not be compared");
	}
}
	;
	

    	//While loop
whileFunc: WHILE'(' NUM ')'';' {
	printf("\nWhile loop found\n");
	int i = $3;
	while(i>0){
		printf("\nWhile Loop variable value is %d", i);
        i=i-1;
	}
}
	;

	//Reading a variable
scanFunc: SCAN'(' ID ')'';'{
	int i = findVarIndex($3);
	printf("\nThis function reads the variable %s\n",vars[i].varName);
    }
	;
	


forLoop: REPEAT NUM TO NUM INC NUM '{' statements '}' {
	printf("\nForward for loop starting");
	int i = $2;
	int j = $4;
	int inc = $6;
	int k;
	for(k=i; k<j; k=k+inc){
		printf("\nValue is %d", k);
	}
    printf("\nForward for loop ended");
		
}
	| REPEAT NUM TO NUM DEC NUM '{' statements '}'{
	printf("\nReverse for loop starting");
	int i = $2;
	int j = $4;
	int dec = $6;
	int k;
	for(k=i; k>j; k=k-dec){
		printf("\nValue is %d", k);
	}
    printf("\nReverse for loop ended");
}
	;



switchCase: SWITCH '(' ID ')' '{' caseNumber defaultOption'}' {
	printf("\nSwitch-case ladder starts here.");
}
	;
caseNumber: CASE NUM '{' statements '}' caseNumber {
	printf("\nMatched Case no is %d", $2);
    break;
}
	|
	;
defaultOption: DEFAULT '{' statements '}'
{
    printf("\nDefault executed\n");
    break;
}
	;


	//If else if and else ladders
	
condition: IF'(' boolianExpr ')''{'statements'}' elif lastElse {
	printf("\nIF condition found");
	int i = $3;
	if(i==1){
		printf("\nIF condition true");
	}
	else{
		printf("\nIF condition false");
	}
}
	;
elif: ELIF '(' boolianExpr ')''{' statements '}' elif {
	printf("\nELIF condition found");
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
lastElse: ELSE '{' statements '}' {
	printf("\nELSE condition found");
}
	|
	;
	
	//Boolian expressions
boolianExpr: expression EQUALS expression {
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

TYPE: CHAR	{$$ = 0; printf("\nCharacter type variable");}
	| FLOAT	{$$ = 2; printf("\nFloat type variable");}
    | INT	{$$ = 1; printf("\nInteger type variable");}
	;

ID1: ID1 ',' ID {
		strcpy(vars[totVars].varName, $3);
		printf("\nThe variable is %s", $3);
		vars[totVars].varDataType =  -9;
		totVars = totVars + 1;
	}
	| ID {
		strcpy(vars[totVars].varName, $1);
		printf("\nThe variable is %s", $1);
		vars[totVars].varDataType =  -9;
		totVars = totVars + 1;
	    strcpy($$, $1); /// edit
    }
	;
	
	// Value Assignment to variable
assignation: ID '=' expression ';' {
	$$ = $3;
		int i = findVarIndex($1);
		if(vars[i].varDataType==0){
			vars[i].cvar = (char*)&$3;
			printf("\nThe variable is %s", vars[i].cvar);
		}
		else if(vars[i].varDataType==1){
			vars[i].ivar = $3;
			printf("\nThe variable is %d", vars[i].ivar);
		}
		else if(vars[i].varDataType==2){
			vars[i].fvar = (float)$3;
			printf("\nThe variable is %f", vars[i].fvar);
		}
    }
	;

expression: e {$$ = $1;}
	;
e: e PLUS e {$$ = $1 + $3; }
	| e MINUS e {$$ = $1 - $3;}
	| e MULTI e {$$ = $1 * $3;}
	| e DIVI e 
	    {if($3 != 0)
	    {
		$$ = $1 / $3;
	    }
	    else{
		printf("\nDivision not possible. Logical Error");
    	}
        }
	| '(' e ')' {$$ = $2;}
    | NUM  {$$ = $1;}
    | SIN e 			{printf("\nThe angle inside sin() is %lf\n",$2,sin($2*3.1416/180)); $$=sin($2*3.1416/180);}
	| COS e			{printf("\nThe angle inside of cos() is %lf\n",$2,cos($2*3.1416/180)); $$=cos($2*3.1416/180);}
    | TAN e 			{printf("\nThe angle inside of tan() is %lf\n",$2,tan($2*3.1416/180)); $$=tan($2*3.1416/180);}
    | LOG10 e 			{printf("\nThe angle inside log10() is %lf\n",$2,(log($2*1.0)/log(10.0))); $$=(log($2*1.0)/log(10.0));}
    
    | ID {
	    int indexOfVar = findVarIndex($1);
	    if(indexOfVar == -9)
	    {
		yyerror("Invalid variable mentioned");
        }
	    else
	    {
		if(vars[indexOfVar].varDataType == 1)
		{
			$$ = vars[indexOfVar].ivar;
		}
		else if(vars[indexOfVar].varDataType == 2)
		{
			$$ = vars[indexOfVar].fvar;
		}
	}
    }
	;

%%



    // C codes
void yyerror(char *s)
{
	fprintf(stderr, "\n%s", s);
}

int main(){

	yyin = freopen("input.txt", "r", stdin); /// taking input
	yyout = freopen("output.txt", "w", stdout); // output in file
	yyparse();
	return 0;
}