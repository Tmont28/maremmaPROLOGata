fib(0, 1).
fib(1, 0).

fib(N, X) :-
	N > 1,
	PN is N - 1,
	PPN is N - 2,
	fib(PN, PX),
	fib(PPN, PPX),
	X is PPX + PX.

fib_stupid(0, 1).
fib_stupid(1, 1).
fib_stupid(_N, X) :-
	fib_stupid(0, 1, 2, X).

fib_stupid(PF, F, N, _) :-
	NN is N + 1,
	X is PF + F,
	asserta(fib_stupid(NN, X)),
	fail.
