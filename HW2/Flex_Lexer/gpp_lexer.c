/*
Harun ALBAYRAK
CSE 341 -Programming Languages - Homework#2
*/

#include <stdio.h>
#include <stdlib.h>
#include "gpp_h.h"

extern int yylex();
extern FILE* yyin;
extern int yylineno;
extern char* yytext;

int print_tokens();

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    int ntoken = yylex();

    FILE *fptr;
    fptr = fopen("parsed_cpp.txt","w");
    while(ntoken,fptr){
        ntoken = print_tokens(ntoken,fptr);
        if(argc > 1 && ntoken == 0){
            exit(1);
        }
    }
    fclose(fptr);
    fclose(yyin);

    return 0;
}

int print_tokens(int number,FILE *fptr){
    switch (number){
    case KW_AND:
        printf("KW_AND\n");
        fprintf(fptr,"KW_AND\n");
        break;
    case KW_OR:
        printf("KW_OR\n");
        fprintf(fptr,"KW_OR\n");
        break;
    case KW_NOT:
        printf("KW_NOT\n");
        fprintf(fptr,"KW_NOT\n");
        break;
    case KW_EQUAL:
        printf("KW_EQUAL\n");
        fprintf(fptr,"KW_EQUAL\n");
        break;
    case KW_LESS:
        printf("KW_LESS\n");
        fprintf(fptr,"KW_LESS\n");
        break;
    case KW_NIL:
        printf("KW_NIL\n");
        fprintf(fptr,"KW_NIL\n");
        break;
    case KW_LIST:
        printf("KW_LIST\n");
        fprintf(fptr,"KW_LIST\n");
        break;
    case KW_APPEND:
        printf("KW_APPEND\n");
        fprintf(fptr,"KW_APPEND\n");
        break;
    case KW_CONCAT:
        printf("KW_CONCAT\n");
        fprintf(fptr,"KW_CONCAT\n");
        break;
    case KW_SET:
        printf("KW_SET\n");
        fprintf(fptr,"KW_SET\n");
        break;
    case KW_DEFFUN:
        printf("KW_DEFFUN\n");
        fprintf(fptr,"KW_DEFFUN\n");
        break;
    case KW_FOR:
        printf("KW_FOR\n");
        fprintf(fptr,"KW_FOR\n");
        break;
    case KW_IF:
        printf("KW_IF\n");
        fprintf(fptr,"KW_IF\n");
        break;
    case KW_EXIT:
        printf("KW_EXIT\n");
        fprintf(fptr,"KW_EXIT\n");
        break;
    case KW_LOAD:
        printf("KW_LOAD\n");
        fprintf(fptr,"KW_LOAD\n");
        break;
    case KW_DISP:
        printf("KW_DISP\n");
        fprintf(fptr,"KW_DISP\n");
        break;
    case KW_TRUE:
        printf("KW_TRUE\n");
        fprintf(fptr,"KW_TRUE\n");
        break;
    case KW_FALSE:
        printf("KW_FALSE\n");
        fprintf(fptr,"KW_FALSE\n");
        break;
    case OP_PLUS:
        printf("OP_PLUS\n");
        fprintf(fptr,"OP_PLUS\n");
        break;
    case OP_MINUS:
        printf("OP_MINUS\n");
        fprintf(fptr,"OP_MINUS\n");
        break;
    case OP_DIV:
        printf("OP_DIV\n");
        fprintf(fptr,"OP_DIV\n");
        break;
    case OP_MULT:
        printf("OP_MULT\n");
        fprintf(fptr,"OP_MULT\n");
        break;
    case OP_OP:
        printf("OP_OP\n");
        fprintf(fptr,"OP_OP\n");
        break;
    case OP_CP:
        printf("OP_CP\n");
        fprintf(fptr,"OP_CP\n");
        break;
    case OP_DBMULT:
        printf("OP_DBMULT\n");
        fprintf(fptr,"OP_DBMULT\n");
        break;
    case OP_OC:
        printf("OP_OC\n");
        fprintf(fptr,"OP_OC\n");
        break;
    case OP_CC:
        printf("OP_CC\n");
        fprintf(fptr,"OP_CC\n");
        break;
    case OP_COMMA:
        printf("OP_COMMA\n");
        fprintf(fptr,"OP_COMMA\n");
        break;
    case COMMENT:
        printf("COMMENT\n");
        fprintf(fptr,"COMMENT\n");
        break;
    case VALUE:
        printf("VALUE\n");
        fprintf(fptr,"VALUE\n");
        break;
    case IDENTIFIER:
        printf("IDENTIFIER\n");
        fprintf(fptr,"IDENTIFIER\n");
        break;
    case ex1:
        exit(1);
        break;
    case ex2:
        printf("SYNTAX ERROR\n");
        fprintf(fptr,"SYNTAX ERROR\n");
        break;

    default:
        break;
    }
    return yylex();
}