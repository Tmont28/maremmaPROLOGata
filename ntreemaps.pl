%%%% ntreemaps.pl


%%%% start-Laboratorio_3

%! Idea: ho bisogno di un text che mi dica cos'e' una treemap e poi un
% nodo.

%! is_treemaps is deterministic.
%! true when Treemap is a term of the form treemap(Name, Root).

is_treemap(treemap(_Name, Root)) :-
    is_node(Root).

%! is_node(Node) is deterministic.
%! true when Node is a node in Treemap

is_node(void).
is_node(node(_Key, _Value, _Left, _Right)).

%! qui controllo la struttura del nodo, non controllo nulla
%  ricorsivamente. (non so ancora se effetivamente funzioni o meno)

%! is_tree(Tree) is det.
%! true when Tree is a tree. Checked recursively.

is_tree(void).
is_tree(node(_Key, _Value, _Left, _Right)) :-
    is_tree(_Left),
    is_tree(_Right).


%! Come si cerca dentro un albero?
%! assumo anche che le chiavi che utilizziamo siano chiavi numeriche

search(K, treemap(_, Root), V):-
    is_node(Root),
    search(K, Root, V).

%!  quando l'albero è vuoto il predicato deve fallire
%!  il valore che sto cercando è lo stesso del nodo, quindi è un fatto:

search(K, node(K, V, _, _), V).

%!  nel caso in cui non unificasse:

search(K, node(KN, VN, L, _), V):-
    K < KN,
    search(K, L, V).

%! i casi che ho a disposizione sono > e <: (minore scendo a sinistra)
%! gli alberi binari di ricerca sono pari

search(K, node(KN, VN, _, R), V):-
     K > KN,
     search(K, R, V).

%!  i casi che ho a disposizione sono > e <: (maggiore scendo a destra)
%!  gli alberi binari di ricerca sono pari

%!  l'idea per la ricerca nell'albero è fare una ricorsione.

%!  inserimento nell'albero:

insert(K, N, void, node(K, N, void, void)).

%!  inserimento 4 argomenti.-> da come risultato una foglia.

%%%% end-Laboratorio_3
%
%
%
%%%% start-Lezione_27/10/22

insert(K, V, node(K, VN, L, R)).

%!  per rimpiazzare un nodo con un altro:

insert(K, V, node(KN, VN, LN, RN), node(K, V, L,R)).

%!  per ottenere nuovi alberi:

insert(K, V, node(KN, VN, LN, RN), node(K, V, L, R)) :-
    K @> KN,
    insert(K, V, node(KN, VN, LN, RN), node(KN, VN, LN, NewRN)).

%!  caso simmetrico diventa:

insert(K, V, node(KN, VN, LN, RN), node(K, V, L, R)) :-
    K @< KN,
    insert(K, V, node(KN, VN, LN, RN), node(KN, VN, NewLN, RN)).




%%%% end-Lezione_27/10/22
%
%
%
%%%% start-Lezione_28/10/22

%!  come stampare un albero?

tree_print(Tree) :-
    tree_print(Tree, 0, t).

%!  stampa albero vuoto:

tree_print(void, Indent, LRT) :-
	nl, %new line -> predicato standard
	tab(Indent), %Indent e' un intero
	format('(~w) void', [LRT]). %~w fa una write dell'argomento e passo uno tra L, R e T

%!  stampa albero non vuoto (e' un nodo):

tree_print(node(K , N, L, R), Indent, LRT) :-
	nl,
	tab(Indent),
	format('(~w) ~w --> ~w', [LRT, K, _V]), %significa che vengono aggiunti alla lista
	I is Indent + 4,
	tree_print(L, I, l),
	tree_print(R, I, r).

%!  costruzione BST:

is_bst(void).

is_bst(node(K, V, L, R)) :-
       is_bst(L),
       is_bst(R),
       node(KL, _, _, _) = L,
       K @> KL,
       node(KR, _, _, _) = R,
       K @< KR.

%!  per definizione se ho una foglia allora ho un BST:

is_bst(_, _, void, void).

%!  caso in cui non ho nulla a destra:

is_bst(node(K, _, node(KL, _, LL, LR)), void) :-
    K @> KL,
    is_bst(LL, K),
    is_bst(LR).

%!  caso in cui non ho nulla a Sinistra:

is_bst(node(K, _, node(KR, _, RR, RL)), void) :-
    K @< KR,
    is_bst(RR, K),
    is_bst(RL).

%!  Come faccio a testare che un BST sia effetivamente un BST?
%   Devo tenere traccia di tutti i nodi precedenti (valore di tutti i
%   nodi deve essere minore).
%   N.B: il test sul controllo delle variabili deve essere fatto in un
%   intervallo.

is_bst(Tree) :-
    is_bst(Tree, -inf, inf).

%!  attenzione: -inf e inf sono valori non definiti.

is_bst(void, _, _).

%!  per tenere traccia devo inserire chiavi numeriche:

is_bst(node(K, _, L, R), KMin, KMax) :-
    KMin < K,
    KMax >= K,
    is_bst(L, KMin, K),
    is_bst(R, K, KMax).

%!  min_node -> mi serve per ritornare il nodo con la chiave minima.

min_node(node(K, V, void, R), node(K, V, void, R)).

%! caso base: non ho piu' figli a sinistra, altrimenti li ho.

min_node(node(_, _, L, _), MinNode) :-
    min_node(L, MinNode).

min_key(Tree, K) :-
    min_node(Tree, node(K, _, _, _)).

min_key_value(Tree, K-V):-
    min_node(Tree, node(K, V, _, _)).

%! da implementare:
% successor_node(K, Tree, SuccNnode) :-



%%%% end-Lezione_28/10/22
%
%
%
%%%% end of file -- ntreemaps.pl
