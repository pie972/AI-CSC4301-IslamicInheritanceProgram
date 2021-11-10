/* Variables */
husband(mohamed, none).
wife(salma, wife).

son(ais, son).
daughter(leila, daughter).

grandSonOfSon(jalil, grandSonOfSon).
grandDaughterofSon(aya, grandDaughterofSon).

grandSonFromSon(none, none).
grandDaughterFromSon(none, none).

father(none, father).
mother(rahma, mother).

grandFather(said, grandFather).
grandMother(rahma, grandMother).


realBrother(none, realBrother).
realSister(none, realSister).

parentalBrother(none, none).
parentalSister(none, none).




/*Heuristics from the inheritance Table: Knowledge table/Knowledge based*/
husbandWithoutChildren(R) :- 
    countNumberOfHusband(H), 
    H == 1 -> findall((X, Y, 1/2), (husband(X, Y)), R), 
    write(R); 
    true.

wifeWithoutChildren(R) :- 
    countNumberOfWife(N), 
    N == 1 -> findall((A, B, 1/4), (wife(A, B)), R), 
    write(R); 
    true.

husbandWithChildren(R) :-
    countNumberOfHusband(N), 
    N == 1 -> findall((A, B, 1/4), (husband(A, B)), R), 
    write(R); 
    true.
                      
wifeWithChildren(R) :-
    countNumberOfWife(N), 
    N == 1 -> findall((A, B, 1/8), (wife(A, B)), R), 
    write(R); 
    true.

daughterWithoutBrother(R) :- 
    countNumberOfDaughters(N), 
    M = 2/(3*N), N >= 2 -> findall((A, B, M), (daughter(A, B)), R), 
    write(R); 
    (countNumberOfDaughters(N), 
    N == 1 -> findall((A, B, 1/2), (daughter(A, B)), R),  
    write(R); 
    true).

sonDaughterWithoutSonDaughterSonSon(R) :- 
    countNumberOfSonDaughters(N), 
    M = 2/(3*N), N >= 2 -> findall((A, B, M), (grandDaughterFromSon(A, B)), R),  
    write(R); 
   (countNumberOfSonDaughters(N), 
   N == 1 -> findall((A, B, 1/2), (grandDaughterFromSon(A, B)), R),  
   write(R); 
   true).

sonDaughterWithDaughterOnly(R) :-  
    countNumberOfSonDaughters(N), 
    /*son daughter with presence of the son sister*/ 
    N == 1 -> findall((A, B, 1/6), (grandDaughterFromSon(A, B)), R),  
    write(R);
    true.

sonSonDaughterWithoutSonAndDaughterAndSonSonAndSonDaughterAndSonSonSon(R) :- 
    countNumberOfSonSonDaughter(N), 
    /*SD without SDSS*/
    C is 3*N, M = 2/C, N >= 2 -> findall((A, B, M), (grandDaughterofSon(A, B)), R),  
    write(R); 
    (countNumberOfSonSonDaughter(N), 
    N == 1 -> findall((A, B, 1/2), (grandDaughterofSon(A, B)), R),  
    write(R);
    true).

sonSonDaughterWithDaughterorSonDaughter(R) :-  
    countNumberOfSonSonDaughter(N), 
    N == 1 -> findall((A, B, 1/6), (grandDaughterofSon(A, B)), R),  
    write(R);
    (countNumberOfSonSonDaughter(N), 
    M = 1/(6*N), N >= 2 -> findall((A, B, M), (grandDaughterofSon(A, B)), R),  
    write(R);   
    true).

fatherWithChildren(R) :-
    countNumberOfFather(F), 
    F == 1 -> findall((A, B, 1/6), (father(A, B)), R),  
    write(R); 
    true.

motherWithChildrenorSiblingsorHusbandplusFather(R) :- 
    countNumberOfMother(M), 
    M == 1 -> findall((A, B, 1/6), (mother(A, B)), R),  
    write(R); 
    true.

motherWithWifePlusFather(R) :- 
    countNumberOfMother(M), 
    M == 1 -> findall((A, B, 1/4), (mother(A, B)), R), 
    write(R); 
    true.

motherCase3(R) :- 
    countNumberOfMother(M), 
    M == 1 -> findall((A, B, 1/3), (mother(A, B)), R), 
    write(R); 
    true.

fatherfatherPresenceOfChildrenAndNoFather(R) :- 
    countNumberOfFatherFather(N), 
    N == 1 -> findall((A, B, 1/6), (grandFather(A, B)), R), 
    write(R); 
    true.
    									


/*Count Numbers of family members: used to */
countNumberOfDaughters(N) :- 
    aggregate_all(count, daughter(_, daughter), N).

countNumberOfSons(N) :- 
    aggregate_all(count, son(_, son), N).

countNumberOfSonSons(N) :- 
    aggregate_all(count, grandSonFromSon(_, grandSonFromSon), N).

countNumberOfSonDaughters(N) :- 
    aggregate_all(count, grandDaughterFromSon(_, grandDaughterFromSon), N).

countNumberOfSonSonDaughter(N) :- 
    aggregate_all(count, grandDaughterofSon(_, grandDaughterofSon), N).

countNumberOfSonSonSon(N) :- 
    aggregate_all(count, grandSonOfSon(_, grandSonOfSon), N).

countNumberOfChildren(N) :- 
    countNumberOfDaughters(A), 
    countNumberOfSons(B), 
    countNumberOfSonSons(C), 
    countNumberOfSonDaughters(D), 
    countNumberOfSonSonDaughter(E), 
    countNumberOfSonSonSon(F), 
    N is (A+B+C+D+E+F).

countNumberOfRealSisters(N) :- 
    aggregate_all(count, realSister(_, realSister), N).

countNumberOfParentalSisters(N) :- 
    aggregate_all(count, parentalSister(_, parentalSister), N).

countNumberOfRealBrothers(N) :- 
    aggregate_all(count, realBrother(_, realBrother), N).

countNumberOfParentalBrothers(N) :- 
    aggregate_all(count, parentalBrother(_, parentalBrother), N).

/*These will either give one or zero*/
countNumberOfHusband(N) :- 
    aggregate_all(count, husband(_, husband), N).

countNumberOfFather(N) :- 
    aggregate_all(count, father(_, father), N).

countNumberOfWife(N) :- 
    aggregate_all(count, wife(_, wife), N).

countNumberOfMother(N) :- 
    aggregate_all(count, mother(_, mother), N).

countNumberOfFatherFather(N) :- 
    aggregate_all(count, grandFather(_, grandFather), N).

countNumberOfSiblings(N) :- 
    countNumberOfRealSisters(A), 
    countNumberOfParentalSisters(B), 
    countNumberOfRealBrothers(C), 
    countNumberOfParentalBrothers(D), 
    N is (A+B+C+D).


/*the go(0) function will help distribute the inheritance inference engine*/
go(R) :- 
    (R == 0 -> husband, wife, go(1); 
    (R == 1 -> daughter,  go(2); 
    (R == 2 -> grandDaughterFromSon, go(3); 
    (R == 3 -> grandDaughterofSon, go(4); 
    (R == 4 -> father, go(5); 
    (R == 5 -> mother, go(6); 
    (R == 6 ->  grandFather)
    )
    )
    )
    )
    )
    ), 
    nl.
/*new line*/


/*Inference Engine*/
husband :- 
    countNumberOfChildren(N), 
    N >= 1 -> husbandWithChildren(_); 
    husbandWithoutChildren(_).

wife :- 
    countNumberOfChildren(N), 
    N >= 1 -> wifeWithChildren(_); 
    (countNumberOfChildren(N), 
    N >= 1 -> wifeWithoutChildren(_); 
    true).

daughter :- 
    countNumberOfSons(N), 
    N == 0 -> daughterWithoutBrother(_); 
    true.
    
grandDaughterFromSon :- 
    countNumberOfSons(N), 
    countNumberOfSonSons(M), 
    countNumberOfDaughters(P), 
    (N == 0, M == 0, P == 0) -> sonDaughterWithoutSonDaughterSonSon(_); 
    (countNumberOfSons(N), 
    countNumberOfSonSons(M), 
    countNumberOfDaughters(P), 
    (N == 0, M == 0, P == 1) -> sonDaughterWithDaughterOnly(_); 
    true).

grandDaughterofSon :- 
    countNumberOfSons(N), 
    countNumberOfSonSons(M), 
    countNumberOfDaughters(P), 
    countNumberOfSonSonSon(W), 
    countNumberOfSonDaughters(K), 
    (N == 0 , M == 0, P == 0, K == 0, W == 0) -> sonSonDaughterWithoutSonAndDaughterAndSonSonAndSonDaughterAndSonSonSon(_); 
    (countNumberOfSons(N), 
    countNumberOfSonSons(M), 
    countNumberOfDaughters(P), 
    countNumberOfSonSonSon(W), 
    countNumberOfSonDaughters(K), 
    (N == 0, M == 0, (P == 1; K == 1), W == 0) -> sonSonDaughterWithDaughterorSonDaughter(_); 
    true).

father :- 
    countNumberOfChildren(N), 
    N > 0 -> fatherWithChildren(_); 
    true.

mother :- 
    countNumberOfChildren(C),
    countNumberOfSiblings(S), 
    countNumberOfHusband(H), 
    countNumberOfFather(F),
    (C > 0; S > 0; (H == 1, F == 1)) ->  motherWithChildrenorSiblingsorHusbandplusFather(_);   
    (countNumberOfWife(W), countNumberOfFather(F), 
    W == 1, F == 1 -> motherWithWifePlusFather(_); 
    motherCase3(_), 
    true).
    				
grandFather :- 
    countNumberOfChildren(C), 
    countNumberOfFather(F), 
    C > 0, F == 0 -> fatherfatherPresenceOfChildrenAndNoFather(_); 
    true.
