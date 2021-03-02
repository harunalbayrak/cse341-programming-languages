%{ 
#include <stdio.h>    
#include <stdlib.h>    
#include <string.h>    
#include <ctype.h>
#include <math.h>
#include "gpp_interpreter.h"
int yylex(void);
void yyerror (const char* s);
void yyrestart (FILE* input_file);
extern FILE *yyin;
int sym[60];
%}

%union {int num; char id[100]; int *array;}
%start START
%token COMMENT KW_LIST KW_DEFFUN KW_AND KW_OR KW_NOT KW_EQUAL KW_LESS KW_NIL KW_APPEND KW_CONCAT;
%token KW_SET KW_FOR KW_IF KW_EXIT KW_LOAD KW_DISP KW_TRUE KW_FALSE;
%token OP_OP OP_CP OP_PLUS OP_MINUS OP_DIV OP_MULT OP_DBMULT OP_OC OP_CC OP_COMMA;
%token ex1;
%token ex2;
%left OP_PLUS OP_MINUS
%left OP_MULT OP_DIV
%right KW_NOT
%token <num> VALUE
%token <id> IDENTIFIER
%type <num> EXPI
%type <num> EXPB
%type <array> NUMBERS
%type <array> EXPLISTI

%%

START: COMMENT {}
    | START COMMENT {}
    | OP_OP KW_EXIT OP_CP { exit(1);}
    | START OP_OP KW_EXIT OP_CP { exit(1);}
    | EXPI { printf("%d\n", $1); }
    | START EXPI { printf("%d\n", $2); }
    | EXPB { if($1 == 1){printf("true\n");} else{printf("false\n");} }
    | START EXPB { if($2 == 1){printf("true\n");} else{printf("false\n");} }
    | EXPLISTI { printList2($1); }
    | START EXPLISTI { printList2($2); }
    ;

NUMBERS: EXPI { $$ = initialList($1); }
       | NUMBERS EXPI { $$ = secondInitialList($1, $2); }
       ;

EXPI: VALUE { $$ = $1; }
    | IDENTIFIER { initialIdentifier($1); }
    | OP_OP OP_PLUS NUMBERS OP_CP { $$ = additionList($3); }
    | OP_OP OP_MINUS NUMBERS OP_CP { $$ = substractionList($3); }
    | OP_OP OP_MULT NUMBERS OP_CP { $$ = multiplicationList($3); }
    | OP_OP OP_DIV NUMBERS OP_CP { $$ = divisionList($3); }
    | OP_OP OP_DBMULT NUMBERS OP_CP { $$ = dbMultList($3); }
    | OP_OP KW_SET IDENTIFIER NUMBERS OP_CP { setIdentifier($3,$4); }
    | OP_OP KW_IF EXPB EXPLISTI EXPLISTI OP_CP { $$ = ifList3($3, $4, $5); }
    | OP_OP KW_IF EXPB EXPLISTI OP_CP { $$ = ifList2($3, $4); }
    | OP_OP KW_IF EXPB NUMBERS OP_CP { $$ = ifList($3, $4); }
    | OP_OP KW_FOR EXPB NUMBERS OP_CP { $$ = ifList($3, $4); }
    | OP_OP KW_FOR OP_OP IDENTIFIER EXPI EXPI OP_CP EXPLISTI OP_CP { $$ = forList($5,$6,$8); }
    | OP_OP KW_DISP NUMBERS OP_CP { $$ = $3[1]; }
    | OP_OP KW_DEFFUN IDENTIFIER EXPLISTI OP_CP { funcDefiniton1($4); }
    | OP_OP KW_DEFFUN IDENTIFIER OP_OP IDENTIFIER OP_CP EXPLISTI OP_CP { funcDefiniton2($5,$7); }
    | OP_OP KW_DEFFUN IDENTIFIER OP_OP IDENTIFIER IDENTIFIER OP_CP EXPLISTI OP_CP { funcDefiniton3($5,$6,$8); }
    ;

EXPB: KW_TRUE { $$ = 1; }
    | KW_FALSE { $$ = 0; }
    | OP_OP KW_EQUAL NUMBERS OP_CP { $$ = equalList($3); }
    | OP_OP KW_LESS NUMBERS OP_CP { $$ = lessList($3); }
    | OP_OP KW_AND EXPB EXPB OP_CP { $$ = $3 && $4; }
    | OP_OP KW_OR EXPB EXPB OP_CP { $$ = $3 || $4; }
    | OP_OP KW_NOT EXPB OP_CP { $$ = !$3; }
    | OP_OP KW_EQUAL EXPB EXPB OP_CP { $$ = $3 == $4; }
    | OP_OP KW_DISP EXPB OP_CP { $$ = $3; }
    ;

EXPLISTI: OP_OP KW_LIST OP_CP { $$ = NULL; }
        | KW_NIL { $$ = NULL; }
        | OP_OP KW_LIST NUMBERS OP_CP { $$ = $3; }
        | OP_OP KW_APPEND NUMBERS EXPLISTI OP_CP { $$ = appendList($3,$4); }
        | OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP { $$ = concatList($3,$4); }
        | OP_OP KW_DISP EXPLISTI OP_CP { $$ = printList($3); }
        ;


%%

int main(int argc, char** argv){
    if(argc > 1) {
        yyin = fopen(argv[1], "r");
        if(yyparse()) {
            fclose(yyin);
        }
        return 0;
    }
    yyin = stdin;
    yyrestart(yyin);
    return yyparse();
}

void yyerror(const char *s){
    char *arr2 = ". Expression not recognized.";
    char *result = malloc(strlen(s) + strlen(arr2) + 1);

    strcpy(result, s);
    strcat(result, arr2);
    
    fprintf(stderr, "%s\n", result);
}