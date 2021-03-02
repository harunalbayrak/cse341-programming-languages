flight(istanbul,antalya).
flight(istanbul,izmir).
flight(istanbul,gaziantep).
flight(istanbul,ankara).
flight(istanbul,van).
flight(istanbul,rize).
flight(rize,van).
flight(rize,istanbul).
flight(van,ankara).
flight(van,rize).
flight(van,istanbul).
flight(ankara,van).
flight(ankara,istanbul).
flight(ankara,konya).
flight(konya,ankara).
flight(konya,antalya).
flight(gaziantep,antalya).
flight(gaziantep,istanbul).
flight(antalya,gaziantep).
flight(antalya,konya).
flight(antalya,istanbul).
flight(burdur,isparta).
flight(isparta,burdur).
flight(isparta,izmir).
flight(izmir,isparta).
flight(izmir,istanbul).
flight(erzincan,edremit).
flight(edremit,erzincan).
flight(edremit,edirne).
flight(edirne,edremit).

distance(istanbul, antalya, 481). 
distance(istanbul, izmir, 328). 
distance(istanbul, gaziantep, 847). 
distance(istanbul, ankara, 351). 
distance(istanbul, van, 1262). 
distance(istanbul, rize, 967). 
distance(rize, van, 373). 
distance(rize, istanbul, 967). 
distance(van, ankara, 920). 
distance(van, rize, 373). 
distance(van, istanbul, 1262). 
distance(ankara, van, 920). 
distance(ankara, istanbul, 351). 
distance(ankara, konya, 227). 
distance(konya, ankara, 227). 
distance(konya, antalya, 192). 
distance(gaziantep, antalya, 592). 
distance(gaziantep, istanbul, 847). 
distance(antalya, gaziantep, 592). 
distance(antalya, konya, 192). 
distance(antalya, istanbul, 481). 
distance(burdur, isparta, 24). 
distance(isparta, burdur, 24). 
distance(isparta, izmir, 308). 
distance(izmir, isparta, 308). 
distance(izmir, istanbul, 328). 
distance(erzincan, edremit, 736). 
distance(edremit, erzincan, 736). 
distance(edremit, edirne, 914). 
distance(edirne, edremit, 914). 

sroute(X,Y,D) :- flight(X,Y),not(X==Y),distance(X,Y,D).
sroute(X,Y,D) :- flight(X,Z),distance(X,Z,A),flight(Z,Y),distance(Z,Y,B),not(X==Y),not(Z==Y),not(X==Z),(D is A+B).
sroute(X,Y,D) :- flight(X,Z),distance(X,Z,A),flight(Z,T),distance(Z,T,B),flight(T,Y),distance(T,Y,C),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),(D is A+B+C).