%{
#include "y.tab.h"
%}

%%

";;".* return COMMENT;
list return KW_LIST;
deffun return KW_DEFFUN;
and return KW_AND;
or return KW_OR;
not return KW_NOT;
equal return KW_EQUAL;
less return KW_LESS;
nil return KW_NIL;
append return KW_APPEND;
concat return KW_CONCAT;
set return KW_SET;
for return KW_FOR;
if return KW_IF;
exit return KW_EXIT;
load return KW_LOAD;
disp return KW_DISP;
true return KW_TRUE;
false return KW_FALSE;
"(" return OP_OP;
")" return OP_CP;
"+" return OP_PLUS;
"-" return OP_MINUS;
"/" return OP_DIV;
"*" return OP_MULT;
"**" return OP_DBMULT;
"“" return OP_OC;
"”" return OP_CC;
"," return OP_COMMA;
[%.&|\\$#£€₺!?\{\}\[\]~=] return ex2;
[_a-zA-Z][-_a-zA-Z0-9]* {strcpy(yylval.id, yytext); return IDENTIFIER;}
[0] {yylval.num = atoi(yytext); return VALUE;}
[0][0-9]* return ex2;
[0-9]* {yylval.num = atoi(yytext); return VALUE;}
[0-9]*[_a-zA-Z]* return ex2;
"\n\n" return ex1;
[ \t\n] ;

%%

int yywrap(){
    return 1;
}
