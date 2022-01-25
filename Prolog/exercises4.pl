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

%b
score(Company, Score) :- setof(Destination, (Or, Code, Hour, Dur)^flight(Or, Destination, Company, Code, Hour, Dur), Destinations),
                         length(Destinations, Score).

most_diversified([Company], Company).
most_diversified([Company | T], Company) :- most_diversified(T, NextBest),
                                            score(Company, BestScore),
                                            score(NextBest, NextBestScore),
                                            BestScore >= NextBestScore.
most_diversified([Competitor | T], Company) :- score(Competitor, CompScore),
                                               score(Company, BestScore),
                                               BestScore >= CompScore,
                                               most_diversified(T, Company).

most_diversified(Company) :- setof(Company, (Or,Dest,Code,Hour,Dur)^flight(Or, Dest, Company, Code, Hour, Dur), Companies),
                             most_diversified(Companies, Company).

%c
connects_dfs(S, F, C) :- connects_dfs(S, F, [S], C).

connects_dfs(F, F, _Path, []).        
connects_dfs(S, F, T, [C | R]):- flight(S, N, _, C, _, _),
                           \+ member(N, T),
                           connects_dfs(N, F, [N|T], R).

find_flights(Or, Dest, Flights) :- connects_dfs(Or, Dest, Flights).

%d
connects_bfs(S, F, C):- connects_bfs([S], F, [S], C).

connects_bfs([F|_], F, _V, []).
connects_bfs([S|R], F, V, [C | R]):- findall(N,
                                        (flight(S, N, _, C, _, _),
                                        not(member(N, V)),
                                        not(member(N, [S|R]))), L),
                                     append(R, L, NR),
                                     connects_bfs(NR, F, [S|V], R).

find_flights_breadth(Or, Dest, Flights) :- connects_dfs(Or, Dest, Flights).

%e
find_all_flights(Or, Dest, ListOfFlights) :- bagof(F, find_flights(Or, Dest, F), ListOfFlights).









%3
%4
%5
%6