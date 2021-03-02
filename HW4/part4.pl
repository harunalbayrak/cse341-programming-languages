element(E,S) :- member(E,S).

union(S1,S2,S3) :- append(S1,S2,X), list_to_set(X,Y), equivalent(Y,S3). 

intersect(S1, S2, []).
intersect(S1, S2, [X|Y]) :- memberchk(X, S1), memberchk(X, S2), intersect(S1, S2, Y), !.

equivalent(S1,S2) :- msort(S1,T),msort(S2,Z),(T==Z).