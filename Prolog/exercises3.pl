%1
%a) X=1?; X=2?; no
%b) X=1, Y=1?;  X=1, Y=2?; X=2, Y=1?; X=2, Y=2?; no
%c) X=1?, Y=1?; X=1?, Y=2?; no

%note: ! não consegue andar para trás nem para a frente

%2
%a) X=one?; X=two?; X=three?; X=`five`?; no
%b) X=one?; no
%c) X=one, Y= one?; X=one, Y= two?; X=one, Y= three?

%3
%immature(X):- adult(X), !, fail.   => Cut Vermelho (por causa de baixo)
%immature(X). 


%adult(X):- person(X), !, age(X, N), N >=18. 
%adult(X):- turtle(X), !, age(X, N), N >=50.
%adult(X):- spider(X), !, age(X, N), N>=1.   
%adult(X):- bat(X), !, age(X, N), N >=5.  => Cut Verde (pq assumindo que se X é de uma espécie, não vai ser das outras - cut a ser usado para melhorar eficiência)


%4.
%a 
print_n(_, 0).
print_n(S, N) :- write(S),
                 Next is N-1,
                 print_n(S, Next).
%b
print_text(Text, Symbol, Padding) :- write(Symbol),
                                     print_n(' ', Padding),
                                     print_string(Text),
                                     print_n(' ', Padding), 
                                     write(Symbol).            

print_string([]).
print_string([H | T]) :- put_code(H),
                         print_string(T).



%d
read_number_aux(N, N) :- peek_code(10), !, skip_line.
read_number_aux(Acc, N) :- get_code(A),
                           Res is Acc * 10 + A - 48,
                           read_number_aux(Res, N).

read_number(X) :- read_number_aux(0, X).
                  

%e
read_until_between(Min, Max, X) :- read_number(X),
                                   X > Min, 
                                   X < Max,
                                   !.             
read_until_between(Min, Max, Value) :- read_until_between(Min, Max, Value).

%i
print_row(Symbol, N, Padding) :- print_n(' ', Padding), print_n(Symbol, N).

oh_christmas_tree(_, 0). 
oh_christmas_tree(P, N) :- Nr is N-1,
                           P1 is P+2,
                           print_row('*', P1, Nr),
                           nl,
                           oh_christmas_tree(P1, Nr).

oh_christmas_tree(N) :- oh_christmas_tree(-1, N),
                        Nr is N-1,
                        print_row('*', 1, Nr).

%5.
%a
children(Person, Children) :- findall(Child, parent(Person, Child), Children).

%d
couple(P1-P2) :- parent(P1, X), parent(P2, X), P1 @< P2. 

%e
couples(List) :- setof(C, couple(C), List).

%h
parent_of_two(P1-P2) :- parent(P1, X), parent(P2, X), parent(P1, Y), parent(P2, Y), P1 @< P2, X @< Y.
parents_of_two(Parents) :- setof(C, parent_of_two(C), Parents).

%6.
leciona(algoritmos, adalberto).
leciona(bases_de_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).


frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

frequenta(bases_de_dados, antonio).
frequenta(bases_de_dados, bruno).
frequenta(bases_de_dados, cristina).
frequenta(bases_de_dados, duarte).
frequenta(bases_de_dados, eduardo).

frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).

aluno(X, Y) :- frequenta(UC, X), leciona(UC, Y).

colega(X, Y, UC) :- frequenta(UC, X), frequenta(UC, Y), (X \= Y).

%a %b
teachers(T) :- setof(Teacher, UC^leciona(UC, Teacher), T).

%c
students_of(T, S) :- setof(Student, UC^(leciona(UC, T), frequenta(UC, Student)), S).

%d
teachers_of(S, T) :- setof(Teacher, UC^(leciona(UC, Teacher), frequenta(UC, S)), T).

%e
common_courses(S1, S2, -C) :- setof(UC, colega(S1, S2, UC), C).

%f
more_than_one_course(L) :- setof(Student, (UC1, UC2)^(frequenta(UC1, Student), frequenta(UC2, Student), UC1 \= UC2), L).

%g
:-use_module(library(ordsets)).

strangers(L) :- setof(S1-S2, (UC1,UC2)^(frequenta(UC1, S1), frequenta(UC2, S2), S1 \= S2), StudentPairs),
                setof(S1-S2, UC^colega(S1, S2, UC), MatePairs),
                ord_subtract(StudentPairs, MatePairs, L).

%h
good_groups(L) :- setof(S1-S2, (UC1, UC2)^(frequenta(UC1, S1), frequenta(UC2, S1), frequenta(UC1, S2), frequenta(UC2, S2), UC1 \= UC2, S1 \= S2), L).