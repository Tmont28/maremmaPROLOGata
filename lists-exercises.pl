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



%conta(T,L,N) /3
%T = a -> L = [a,a,a,a,b] N = 4.
% [1 , 2, 1] t = 1
conta(_, [], 0).

conta(T, [X| Xs], N) :-
   	T = X,
    conta(T, Xs, K),!,
    N is K + 1.

conta(T, [_| Xs], N) :-
     conta(T, Xs, N).

% insert(N,L,K) -> N elemento da inserire L la lista in cui inseriere
% K risultato finale -> K deve avere tutto ordinato.

% insert(3,[[1,2,3,4,5],[1,2,3,3,4]) = TRUE
% K = 2 [1,2,3,4]

insert(X, [], [X]).

insert(X, [L1| L1s], [X, L1| L1s]):-
    X @< L1, !.

insert(X, [L1| L1s], [L1|L2s]) :-
    insert(X, L1s, L2s).
