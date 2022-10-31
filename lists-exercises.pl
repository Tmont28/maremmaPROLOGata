%! appendi(L1,L2,L3) is nondet.
%
%  il predicato e' vero quando la lista L3 e' la concatenazione di L1 e L2.

appendi([], Xs, Xs).

appendi([X | Xs], Ys, [X | Zs]):-
    appendi(Xs, Ys, Zs).



%!  listref(L, N, E) is semidet.
%
%   il predicato e' vero quando E e' l'elemento nella posizione N-esima di L 
%   (ha complessita' lineare).
%   Il caso base si trova nell'elemento iniziale.

listref([E | _], 0, E):-
    !.

listref([_ | Es], N, E) :-
    N > 0,
    !,
    N1 is N - 1,
    listref(Es, N1, E).


%!  part(E, L) is nondet.
%
%   il predicato e' vero quando E e' parte della lista L.
%

part(E, [E | _]).

part(E, [_ | Es]):-
    part(E, Es).

