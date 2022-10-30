%%%% -*- Mode: Prolog -*-
%%%% ntreemas

%% la mia struttura di un nodo sara
%
% node( key, value, left, right)

is_treemap(treemap(_Name, Root)) :-
	is_node(Root).

isnode(void).
isnode(node(_Key,_Value,_Left,_Right)).

istree(void).
istree(node(_Key, _Value, Left, Right)) :-
    istree(Left),
    istree(Right).

%% searching in all the trees for a node
search(K, treemap(_Name, Root), V) :-
    isnode(Root),
    search(K, Root, V).

search(K, node(K, V, _Left, _Right), V).

search(K, node(KN, _, L, _), V) :-
    K < KN,
    search(K, L, V).

search(K, node(KN, _, _, R), V) :-
    K > KN,
    search(K, R, V).

%% printing the tree

tree_print(Tree) :-
	tree_print(Tree, 0, _T).

tree_print(void, Indent, LRT) :-
	nl,
	tab(Indent),
	format('(~w) void', [LRT]).
	%% passo uno tra L,R o T
	%insert(K, N, void, node(K, N, void, void))
	
tree_print(node(K , _N, L, R), Indent, LRT) :-
	nl,
	tab(Indent),
	format('(~w) ~w --> ~w', [LRT, K, _V]),
	Ind is Indent + 4,
	tree_print(L, Ind, L),
	tree_print(R, Ind, R).

% tree_print(node("1", "ciao", 
%		void, 
%		%node(2, "cazzo", void, void)))
%

%%%%%%%%%%%%%%%%%%%%%%%%%%
% parte di controllo BST %
%%%%%%%%%%%%%%%%%%%%%%%%%%

% se e' vuoto si, e' un bst
is_bst(void).

%% is_bst(K, V, L, R) :-
