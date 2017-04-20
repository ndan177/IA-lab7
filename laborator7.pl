%Daniel Nohai 243
graf([1-2, 1-3, 2-7, 3-4, 3-5, 4-8, 5-8, 6-7, 6-9, 7-8, 8-9]).
membru(E,[E|_]).
membru(E,[_|L]):-membru(E,L).

adiacent(A,B,[A-B|_]).
adiacent(A,B,[B-A|_]).
adiacent(A,B,[_-_|L]):-adiacent(A,B,L).

lista_noduri([],[]).
lista_noduri([A-B|G],L):-lista_noduri(G,L1),(membru(A,L1)->L2=L1;L2=[A|L1]),(membru(B,L2)->L=L2;L=[B|L2]).

%grad_nod(Graf,Nod,Grad)
grad_nod(G,A,N):-bagof(M,adiacent(M,A,G),L),length(L,N).
%length(lista,x)
drum(A,B,Graf,Drum):-drum1(A,[B],Graf,Drum).
drum1(A,[A|L],_,[A|L]):-!.
drum1(A,[X|L],G,D):-adiacent(P,X,G), \+membru(P,[X|L]),drum1(A,[P,X|L],G,D).

conex(G):- \+neconex(G).
neconex(G):-lista_noduri(G,[A|L]),membru(E,L),\+drum(A,E,G,_),!.

aciclic(G):- \+ciclic(G).
ciclic(G):-membru(A-B,G),drum(A,B,G,D),membru(X,D),X\==A,X\==B.

arbore(G):-conex(G),aciclic(G).