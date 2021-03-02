flags = -g
exec = gpp_lexer

$(exec).out: lex.yy.c
	gcc $(flags) lex.yy.c $(exec).c -o $(exec).out

lex.yy.c: $(exec).l
	flex $(exec).l

clean: 
	rm -rf lex.yy.c $(exec).out $(exec).dSYM

