when(102,10).
when(108,12).
when(341,14).
when(455,16).
when(452,17).

where(102,z23).
where(108,z11).
where(341,z06).
where(455,207).
where(452,207).

enroll(a,102).
enroll(a,108).
enroll(b,102).
enroll(c,108).
enroll(d,341).
enroll(e,455).

schedule(S,P,T) :- enroll(S,C),where(C,P),when(C,T).

usage(P,T) :- where(X,P), when(X,T).

conflict(X,Y) :- (not(X==Y)),(where(X,T),where(Y,Z),(T==Z));(when(X,T),when(Y,Z),(T==Z)).

meet(X,Y) :- (not(X==Y)),enroll(X,T),enroll(Y,Z),where(T,C),where(Z,D),(T==Z),(C==D).