%1
:-dynamic parent/2, male/1, female/1.

%a
add_person :- write('Insert (M or F)-Name to add'),nl,
              read(S-N),
              add_person(S-N).

add_person('M'-N) :- assert(male(N)).
add_person('F'-N) :- assert(female(N)).

%b
add_parents(Child) :- write('Insert Parent-Parent to add'),nl,
                      read(P1-P2),
                      assert(parent(P1, Child)),
                      assert(parent(P2, Child)).

%c
remove_person :- write('Insert Person to remove'),nl,
                 read(P),
                 retractall(female(P)),
                 retractall(male(P)),
                 retractall(parent(P, _)),
                 retractall(parent(_, P)).

%2
%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

%a
get_all_nodes(ListOfAirports) :- setof(AeroportFrom, (A, B, C, D, AeroportTo)^
                                (flight(AeroportFrom, AeroportTo, A, B, C, D) ; flight(AeroportTo, AeroportFrom, A, B, C, D))
                                , ListOfAirports).
                            
%nota: ir buscar os aeroportos origem OU aeroportos destino dos flights

%c
connects_dfs(S, F) :- connects_dfs(S, F, [S]).
                      connects_dfs(F, F, _Path).
                      
connects_dfs(S, F, T):- flight(S, N, _, _, _, _),
                        \+ member(N, T),
                        connects_dfs(N, F, [N|T]).


%find_flights(+Origin, +Destination, -Flights) :- 

%d


%h








%3
%4
%5
%6