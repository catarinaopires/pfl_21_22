/* 1 */
/*  male/1, female/1 e parent/2 */

female('Grace').
male('Frank').
male('Phil').
parent('Grace', 'Phil').
parent('Frank', 'Phil').

female('Claire').
female('Haley').
parent('Phil', 'Haley').
parent('Claire', 'Haley').

male('Jay').
female('Gloria').
female('Dede').
female('ToTestEx5hTP3').
parent('Jay', 'Claire').
parent('Dede', 'Claire').
parent('Jay', 'ToTestEx5hTP3').
parent('Dede', 'ToTestEx5hTP3').
parent('Jay', 'Joe').
parent('Gloria', 'Joe').

female('ToTestEx1bTP4').

/* b) parent(X,'Phil'),male(X).
      parent(X,'Phil').male(X).
      halfSiblings(X, Y). 
      halfSiblings('Claire', 'Joanna').
      parent('Jay',X),parent('Gloria', Y),X\=Y.
      
*/

/* father/2, grandparent/2, grandmother/2, siblings/2, halfSiblings/2, cousins/2, uncle/2 */
grandparent(X,Y) :- parent(X, Z), parent(Z, Y).
grandmother(X,Y) :- parent(X, Z), parent(Z, Y), female(X).
siblings(X,Y) :- parent(Z, X), parent(Z,Y), parent(W, X), parent(W,Y), Z \= W.
halfSiblings(X,Y) :- parent(Z, X), parent(W,Y), Z \= W, parent(P, X), parent(P,Y), X \= Y, P \= Z, P \= W, Z @< W.

/* e) marriage('Jay', 'Dede', 1968) 
      divorce('Jay', 'Dede', 2003)
      
      ou

      marriage(1, 'Jay', 'Dede', 1968 )
      marriage(0,'Jay', 'Dede', 2003 )
*/


/* 2 */

/* leciona/2 e frequenta/2 */
leciona('Algoritmos', 'Adalberto').
leciona('Bases de Dados', 'Bernadete').
leciona('Compiladores', 'Capitolino').
leciona('Estatística', 'Diogenes').
leciona('Redes', 'Ermelinda').

frequenta('Algoritmos', 'Alberto').
frequenta('Algoritmos', 'Bruna').
frequenta('Algoritmos', 'Cristina').
frequenta('Algoritmos', 'Diogo').
frequenta('Algoritmos', 'Eduarda').

frequenta('Bases de Dados', 'Antonio').
frequenta('Bases de Dados', 'Bruno').
frequenta('Bases de Dados', 'Cristina').
frequenta('Bases de Dados', 'Duarte').
frequenta('Bases de Dados', 'Eduardo').

frequenta('Compiladores', 'Alberto').
frequenta('Compiladores', 'Bernardo').
frequenta('Compiladores', 'Clara').
frequenta('Compiladores', 'Diana').
frequenta('Compiladores', 'Eurico').

frequenta('Estatística', 'Antonio').
frequenta('Estatística', 'Bruna').
frequenta('Estatística', 'Claudio').
frequenta('Estatística', 'Duarte').
frequenta('Estatística', 'Eva').

frequenta('Redes', 'Alvaro').
frequenta('Redes', 'Beatriz').
frequenta('Redes', 'Cláudio').
frequenta('Redes', 'Diana').
frequenta('Redes', 'Eduardo').

/* a) 
leciona(X, 'Diogenes').
leciona(X, 'Felismina').
frequenta(X, 'Claudio').
frequenta(X, 'Dalmindo').
frequenta(X, 'Eduarda'), leciona(X, 'Bernadete').
frequenta(X, 'Alberto'), frequenta(X, 'Alvaro').
*/

/* b */
aluno(X,Y) :- frequenta(Z, X), leciona(Z, Y), X \= Y.
alunos(X,Y) :- frequenta(Z, Y), leciona(Z, X), X \= Y.      % alunos do prof X
profs(X,Y) :- frequenta(Z, X), leciona(Z, Y), X \= Y.       % profs do aluno X
alunoSameProf(X,Y, W) :- frequenta(Z, W), leciona(Z, X), frequenta(V, W), leciona(V, Y), Z \= V.

colega(X,Y) :- frequenta(Z, X), frequenta(Z, Y), X \= Y.
colega(X,Y) :- leciona(Z, X), leciona(W, Y), X \= Y,  Z \= W.

alunoMultipleUC(X) :- frequenta(Z, X), frequenta(W, X), Z @< W.

/* 3 */
piloto('Lamb').
piloto('Besenyei').
piloto('Chambliss').
piloto('MacLean').
piloto('Mangold').
piloto('Jones').
piloto('Bonhomme').

equipa('Lamb', 'Breitling').
equipa('Besenyei', 'Red Bull').
equipa('Chambliss', 'Red Bull').
equipa('MacLean', 'Mediterranean Racing Team').
equipa('Mangold', 'Cobra').
equipa('Jones', 'Matador').
equipa('Bonhomme', 'Matador').

aviao('Lamb', 'MX2').
aviao('Besenyei', 'Edge540').
aviao('Chambliss', 'Edge540').
aviao('MacLean', 'Edge540').
aviao('Mangold', 'Edge540').
aviao('Jones', 'Edge540').
aviao('Bonhomme', 'Edge540').

circuito('Istanbul').
circuito('Budapest').
circuito('Porto').

venceu('Jones', 'Porto').
venceu('Mangold', 'Budapest').
venceu('Mangold', 'Istanbul').

gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

ganhaEquipa(E, X) :- venceu(V, X), equipa(V, E).

/* b)
i. venceu(X, 'Porto').
ii. ganhaEquipa(E, 'Porto').
iii. gates(C, N), N > 8.
iv. aviao(X, Y), Y \= 'Edge540'.
v. venceu(V, C1), venceu(V, C2), C1 @< C2.
vi. venceu(P, 'Porto'), aviao(P, A).
*/


/* 4 */
traduz(1, Significado) :- Significado = 'Integer Overflow'.
traduz(2, Significado) :- Significado = 'Divisao por zero'.
traduz(3, Significado) :- Significado = 'ID Desconhecido'.


/* 5 */
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

/* 
a)
i.  se um analista pode ser chefiado pelo sisnando  (cargo)
ii. chefe de um técnico e o seu chefe
iii. cargos que são chefiados por supervisor
iv. cargos chefiados por diretor exluindo a felismina 

b)
i.  X = supervisor
ii. X = engenheiro, Y = supervisor
iii. J = analista, P = leonilde
iv. P = supervisor_chefe

c)
*/
chefe_de(X,Y) :- cargo(C, X), cargo(B, Y), chefiado_por(C,B), B \= C.  %C-cargo, B- cargo boss

/* ERRO: MULTIPLE TIMES SAME ANWSER */
sameChefe(X,Y) :- chefe_de(X, B1), cargo(C, B1), chefe_de(Y, B2), cargo(C, B2), B1 @< B2, X  @< Y.


/* DÚVIDA */
notResponsible(C) :- \+(cargo(C, Y), chefiado_por(W, C), W \= C). %REVER
%...

/* 6 */
/*
pairs(X,Y)
    -> d(X)  X = 2
    -> q(Y)  Y = 4     X= 2, Y=4 ? no
        -> q(Y)  Y = 16     X= 2, Y=16 ? no

 ----- backtrack----- (tentar refazer d(x))

    -> d(X) X = 4     
    -> q(Y)  Y = 4     X= 4, Y=4 ? no
        -> q(Y)  Y = 16     X= 4, Y=16 ? no


 ----- backtrack----- (tentar refazer pairs -> avançar para próxima linha - e ver se consegue fazer match)

 pairs(X,X)
    -> u(X)    X=1  Y=1  ? no

 ---- não consegue refazer, não faz mais match ---
 no   

*/


/* 7 */
a(a1, 1).
a(A2, 2).
a(a3, N).
b(1, b1).
b(2, B2).
b(N, b3).
c(X, Y):- a(X, Z), b(Z, Y).
d(X, Y):- a(X, Z), b(Y, Z).
d(X, Y):- a(Z, X), b(Z, Y).

/*
a)
i. a(A, 2).        
      respostas: A = a3, N = 2

ii. b(A, foobar).  
      respostas: A = 2 B2=foobar

iii. c(A, b3).     
      respostas: Y=b3, Z=1, X=a1 =A (N=1)

iv. c(A, B).      
      respostas: Z=1, X= a1, Y=b1
                 z=2, X= a1, Y=b3
                 z=N, X=a3 , Y=b3

v. d(A, B).       
      respostas: X=a1, Y=2
                 X=a3, Y=1
                 X=a3, Y=2
                 X=1, Y=b3 
                 X=2, Y=b1
                 X=2, Y=b3
*/





/*
DÚVIDAS: 5c)
*/
