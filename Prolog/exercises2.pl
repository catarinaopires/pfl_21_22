/* 1 */
%a
fatorial(0, 1).
fatorial(N, F) :- N > 0,
                  N1 is N-1,
                  factorial(N1, F1),
                  F is N*F1.
%tail recursion
fact(0, 1).
fact(N, F) :- f(N, F, 1).

f(0, F, F).  
f(N, F, Acc) :- N > 0,
                N1 is N-1,
                NAcc is Acc*N,
                f(N1, F, NAcc).


%b
somaRec(0, 0).
somaRec(N, Sum) :- N > 0,
                   N1 is N-1,
                   somaRec(N1, S),
                   Sum is N+S.


%c
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :- N > 0,
                   N1 is N-1,
                   N2 is N-2,
                   fibonacci(N1, F1),
                   fibonacci(N2, F2),
                   F is F1+F2.

%d
divisible(X,Y) :- 0 is X mod Y.
divisible(X,Y) :- Y < X - 1,
                  Y1 is Y+1,
                  divisible(X, Y1).

isPrime(2).
isPrime(X) :- X > 1, 
              \+divisible(X, 2).


/* 2 */
%a
ancestor(X, Y) :- parent(X, Y). 
ancestor(X, Y) :- parent(X, Z), 
                  ancestor(Z, Y). 


%b
descendant(X, Y) :- ancestor(Y, X).

/* 3 */
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

superior(X, Y) :- cargo(C1, X), cargo(C2, Y), chefiado_por(C2, C1).
superior(X, Y) :- cargo(C, Y), chefiado_por(C, W), cargo(W, P), superior(X, P).

/* 4 
a) YES
b) NO
c) YES
d) YES (H = pfl , T = [lbaw, redes, ltw] )
e) YES (H = lbaw, T = [ltw] )
f) YES (H = leic, T = [] )
g) NO
h) YES (H = leic, T = [[pfl, ltw, lbaw, redes]] )
i) YES (H = leic, T = Two )
j) YES (Inst = gram, LEIC = feup)
k) YES (One = 1, Two = 2, Tail = [3, 4])
l) YES (One = leic, Rest = [Two | Tail])
*/

/* 5 */
%a
list_size( [ ], 0 ).
list_size( [_|T], L ) :- list_size(T, L1),
                        L is L1+1.

%b
list_sum([], 0).
list_sum([H | T], Sum) :- list_sum(T, Sum1),
                          Sum is H+Sum1.

%c
list_prod([H], H).
list_prod([H | T], Prod) :- list_prod(T, Prod1),
                            Prod is H*Prod1.

%d
inner_product([ ], [ ], 0).
inner_product([H1 | T1], [H2 | T2], Result) :- Prod is H1*H2,
                                               inner_product(T1, T2, R),
                                               Result is Prod + R.

%e
count(_ , [ ], 0).
count(Elem, [Elem | T], N) :- count(Elem, T, N1),
                              N is 1+N1.

count(Elem, [_ | T], N) :- count(Elem, T, N).

/* 6 */
%a
invert(L, Rev):- reverse(L, [], Rev).

reverse([H | T], Acc, Rev):- reverse(T, [H | Acc], Rev).
reverse([], Rev, Rev).

%b
del_one(_, [], []).
del_one(Elem, [Elem | T], T).                                
del_one(Elem, [H | T], [H | L]) :- del_one(Elem, T, L).

%c
del_all(_, [], []).
del_all(Elem, [Elem | T], L) :- del_all(Elem, T, L).                              
del_all(Elem, [H | T], [H | L]) :- del_all(Elem, T, L).

%d
del_all_list([], L, L).
del_all_list([H | T], List1, List2) :- del_all(H, List1, L),
                                       del_all_list(T, L, List2).

%e - REVER ORDEM
del_dups([], []).
del_dups([H | T], R) :- member(H, T), 
                        del_dups(T, R).

del_dups([H | T], [H | R]) :- del_dups(T, R).

%f
list_perm([], []).
list_perm([H | T], L) :- del_one(H, L, L1),
                         list_perm(T, L1).

%g
replicate(0, _, []).
replicate(Amount, Elem, [Elem | List]) :- A is Amount - 1,
                                          replicate(A, Elem, List).

%h
intersperse(_, [], []).
intersperse(Elem, [H | T], [H , Elem | R]) :- intersperse(Elem, T, R).

%i
insert_elem(0, L, Elem, [Elem | L]).
insert_elem(Index, [H | T], Elem, [H | L]) :- Next is Index - 1,
                                              insert_elem(Next, T, Elem, L).

%j
delete_elem(0, [Elem | L], Elem, L).
delete_elem(Index, [H | T], Elem, [H | L]) :- Next is Index - 1,
                                              delete_elem(Next, T, Elem, L).

%k
replace(L, Index, Old, New, R) :- delete_elem(Index, L, Old, L1),
                                  insert_elem(Index, L1, New, R).

/* 7 */
%a
list_append([], L, L).
list_append([H | T], L2, [H | L]) :- list_append(T, L2, L).

%b
list_member(Elem, [Elem | _]).
list_member(Elem, [_ | T]) :- list_member(Elem, T).

%c
list_last([Last | []], Last).
list_last([_ | T], Last) :- list_last(T, Last).

%d
%list_nth(?N, ?List, ?Elem)

%e
%f
%g
%h
%i
%j
%k





/* 8 */
%a

%b
list_from_to(Inf, Sup, [Inf | T]) :-  Inf < Sup,
                                      Inf1 is Inf + 1, 
                                      list_from_to(Inf1, Sup, T).
list_from_to(Sup, Sup, [Sup]).

%c
list_from_to_step(Inf, Step, Sup, [Inf | T]) :- Inf < Sup,
                                                Next is Inf + Step,
                                                list_from_to_step(Next, Step, Sup, T).

list_from_to_step(Inf, Step, Sup, []) :- Inf > Sup.
list_from_to_step(Sup, _, Sup, [Sup]).

%d
:- use_module(library(lists)).

list_from_to2(Inf, Sup, List) :- Inf > Sup,
                                 list_from_to(Sup, Inf, Rev),
                                 reverse(Rev, List).
list_from_to2(Inf, Sup, List) :- Inf =< Sup,
                                 list_from_to(Inf, Sup, List).

list_from_to_step2(Inf, Step, Sup, List) :- Inf > Sup,
                                            list_from_to_step(Sup, Step, Inf, Rev),
                                            reverse(Rev, List).
list_from_to_step2(Inf, Step, Sup, List) :- Inf =< Sup,
                                            list_from_to_step(Inf, Step, Sup, List).
%e


%f

/* 9 */
%a - FIX REMOVE EXTRAS
count(_, [], R, R).
count(C, [C | L], N, Acc) :-  Res is N + 1,
                              count(C, L, Res, Acc).
count(C, [Y | L], R, R).


rle([C | L1], [C-Count | L2]) :- count(C, L1, 1, Count),
                                 rle(L1, L2).
rle([], []).

%b
un_rle([], []).
un_rle([C-1 | L], [C | T]) :- un_rle(L, T).
un_rle([C-N | L], [C | T]) :- Next is N-1,
                              un_rle([C-Next | L], T). 


/* 10 */
/* 11 */

/*
TODO: REVER 6e), 9a)
7-11

*/