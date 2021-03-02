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

route(X,Y):- flight(X,Y),flight(Y,X),not(X==Y).
route(X,Y):- flight(X,Z),flight(Z,Y),not(X==Y),not(Z==Y),not(X==Z).
route(X,Y):- flight(X,Z),flight(Z,T),flight(T,Y),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z).