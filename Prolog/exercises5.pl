% 1
% a - map(+Pred, +List1, ?List2)
double(X, Y):- Y is X*2. 

map(P, [H], [R]) :-  G =.. [P, H, R], G.
map(P, [H|T], [R | L]):-
                G =.. [P, H, R],
                G,
                map(P, T, L).

% b
% fold(+Pred, +StartValue, +List, ?FinalValue)
sum(A, B, S):- S is A+B.

fold(P, S, [H], R) :-  R is S + S. 
fold(P, S, [H|T], F):-
                G =.. [P, S, H, R],
                G,
                fold(P, R, T, F).

% c
% separate(+List, +Pred, -Yes, -No)
even(X):- 0 =:= X mod 2.

separate([], _, [], []).
separate([H|T], P, [H|Yes], No) :- 
                G =.. [P, H],
                G,
                separate(T, P, Yes, No).

separate([H|T], P, Yes, [H|No]) :- 
                G =.. [P, H],
                \+ G,
                separate(T, P, Yes, No).

% d
ask_execute :-  write('Insira o que deseja executar'),nl,
                read(C),
                C.
%2
%a
my_arg(Index, Term, Arg) :- Term =.. [_Name | Args],
                            nth1(Index, Args, Arg).

/*
my_arg(Position,f(a,b,c),Arg).

Position = 1, Arg = a ;
Position = 2, Arg = b ;
Position = 3, Arg = c.
*/

my_functor(Term, Name, Arity) :- Term =.. [Name, Args],
                                 length(Args, Arity).

/*
my_functor(parent(homer, bart), Name, Arity).
Name= parent,
Arity = 2

my_functor(Term, parent, 2).
Term= parent(_A, _B)
*/

%b
get_args(Final, N, _, []) :- Final is N+1.
get_args(N, Arity, Term, [H | T]) :- arg(N, Term, H),
                                     NewVal is N + 1,
                                     get_args(NewVal, Arity, Term, T).

univ(Term, [Name | Args]) :- functor(Term, Name, Arity),
                             get_args(1, Arity, Term, Args).

%c
:-op(500, xfx, univ).


% 3
:-op(500, xfx, na).
:-op(500, yfx, la).
:-op(500, xfy, ra).

% (na) - não pode ter filhos com mesma precedência
% (la) - pode ter filhos com mesma precedencia à esquerda
% (ra) - pode ter filhos com mesma precedencia à direita

% a) a ra b na c
/*  ra
   /   \
 a     na
      /  \
     b    c
*/

% b) a la b na c
/*  
não seria possível criar
*/

% c) a na b la c
/*
    la
   /   \
  na    c
 /  \
a    b

*/

% d) a na b ra c
/*
Não é possível, pq ra é associativo à direita, logo o na teria de estar à direita
*/

% e) a na b na c
/*
Impossível pq nenhum na pode ficar com filhos
*/

% f) a la b la c
/*
    la
   /   \
  la    c
 /  \
a    b

*/

% g) a ra b ra c
/*
     ra
   /   \
 a     ra
      /  \
     b    c
*/


% 4
:-op(550, xfx, de).
:-op(500, fx, aula).
:-op(550, xfy, pelas).
:-op(550, xfx, e).
:-op(600, xfx, as).
% y significa que tem precedência para esse lado

% a) aula t de pfl as segundas pelas 11
/*

                as
            /         \
                        
        de              pelas
    /       \           /   \
aula        pfl    segundas   11
   \ 
    t
*/



% b) aula tp de pfl as tercas pelas 10 e 30
/*

                as
            /         \

        de              pelas
    /       \           /   \
aula        pfl    tercas   e
   \                       / \
    tp                    10  30
*/



%c) aula 11 e aula 12 as 4 pelas cinco pelas 6 pelas sete
/*
                   as 

              /          \
               
          e               pelas
        /   \             /    \
    aula     aula        4     pelas
       \       \               /   \
       11       12         cinco   pelas
                                   /   \
                                  6    sete
*/

% 5
% a) flight tp1949 from porto to lisbon at 16:15
:-op(500, fx, flight).
:-op(600, xfx, from).
:-op(550, xfy, to).
:-op(550, xfy, at).
:-op(500, xfx, :).
flight tp1949 from porto to lisbon at 16:15.

% b) if X then Y else Z
:-op(550, fx, if).
:-op(600, xfx, then).
:-op(550, xfy, else).
if X then Y else Z :- X, Y.
if X then Y else Z :- \+ X, Z.

% 6
% a) Element exists_in List
:-op(600, xfx, exists_in).
Element exists_in List :- member(Element, List).

% b) append A to B results C
:-use_module(library(lists)).

:-op(500, fx, append).
:-op(600, xfx, to).
:-op(500, xfx, results).

append A to B results C :- append(B, A, C).

% c) remove Elem from List results Result
:-op(500, fx, remove).
:-op(600, xfx, from).
:-op(500, xfx, results).

remove Elem from List results Result :- delete(List, Elem, Result).

