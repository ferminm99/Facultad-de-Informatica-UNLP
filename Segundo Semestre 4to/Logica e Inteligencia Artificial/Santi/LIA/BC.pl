padre(jose,pablo).
padre(pablo,timmy).
padre(pablo,timon).
padre(pablo,melisa).
madre(telma,pablo).
madre(marta,timmy).
madre(marta,timon).
madre(marta,melisa).
mujer(marta).
mujer(melisa).
mujer(telma).
hombre(jose).
hombre(pablo).
hombre(timmy).
hombre(timon).

progenitor(P1,P2) :- padre(P1,P2);madre(P1,P2).
hermano(P1,P2) :- progenitor(P3,P1),progenitor(P3,P2),hombre(P1).
hermana(P1,P2) :- progenitor(P3,P1),progenitor(P3,P2),mujer(P1).
abuela(P3,P1) :- progenitor(P3,P2),progenitor(P2,P1),mujer(P3).
abuelo(P3,P1) :- progenitor(P3,P2),progenitor(P2,P1),hombre(P3).
