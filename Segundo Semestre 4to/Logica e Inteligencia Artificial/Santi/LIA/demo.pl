perro(rita).
gato(iggy).
gato(turlo).
gato(fei).
tiene(fei,garras).
tiene(fei,patas).
tiene(fei,orejas).
tiene(fei,cola).
animal(X) :- gato(X),es_apto_para_animal(X). 
es_apto_para_animal(X) :- tiene(X,Y).