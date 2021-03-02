my_last_element(X,[X]).
my_last_element(X, [_|L]) :- my_last_element(X, L).

separate(X,Y,Z) :- append(Y,Z,X), Y = [_|_], Z = [_|_].

createEq(X,Y,Z) :- Z=X+Y ; Z=X-Y ; Z=X*Y ; Z = X/Y,not(Y=:=0).

equation(A,B) :- append(C,_,A), C = [_|_], equation2(C,B), my_last_element(X,A), B =:= X.

equation2([X],X).
equation2(X,Y) :- separate(X,A,B), equation2(A,C), equation2(B,D), createEq(C,D,Y).

part5(A) :- equation(A,B), my_last_element(X,A), write_part5(B,X), writef('%w = %w\n',[B,X]), writef('Written in output.txt\n').

main:-
   open('input.txt',read,Str),
   read(Str,Input1),
   part5(Input1),
   close(Str),
   write(Input1),  nl.

write_part5(LT,X) :-
   open('output.txt',write,Out),
   write(Out,LT),
   write(Out," = "),
   write(Out,X),
   close(Out).