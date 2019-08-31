% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

solve(S) :-
	S = [_,_,_,_,_],
	nationality(O1,englishman),color(O1,red),member(O1,S),
	color(O2,green),drink(O2,coffee),member(O2,S),
	nationality(O3,italian),drink(O3,tea),member(O3,S),
	color(O4,yellow),cigarette(O4,kent),member(O4,S),
	drink(O5,milk),middle(O5,S),
	nationality(O6,russian),leftmost(O6,S),
	cigarette(OA7,marlboro),pet(OB7,fox),near(OA7,OB7,S),
	cigarette(OA8,kent),pet(OB8,horse),near(OA8,OB8,S),
	drink(O9,juice),cigarette(O9,pall_mall),member(O9,S),
	nationality(O10,japanese),cigarette(O10,assos),member(O10,S),
	nationality(OA11,russian),color(OB11,blue),near(OA11,OB11,S),
	nationality(O12,spanish),pet(O12,dog),member(O12,S),
	pet(O13,snake),cigarette(O13,camel),member(O13,S),
	color(OA14,gray),color(OB14,green),near(OA14,OB14,S),
	pet(OA15,cat),drink(OB15,vodka),lateral(OA15,S),lateral(OB15,S).

color([Color,_,_,_,_],Color).
nationality([_,Nationality,_,_,_],Nationality).
drink([_,_,Drink,_,_],Drink).
cigarette([_,_,_,Cigarette,_],Cigarette).
pet([_,_,_,_,Pet],Pet).
leftmost(X,[X,_,_,_,_]).
middle(X,[_,_,X,_,_]).
lateral(X,[X,_,_,_,_]).
lateral(X,[_,_,_,_,X]).
left(A,B,S) :- append(_,[A,B|_],S).
near(A,B,S) :- left(A,B,S).
near(A,B,S) :- left(B,A,S).

%1

roads(S) :- S=[_,_,_,_], dist(a, c, S, D1), dist(c, d, S, D2), D1 > D2, dist(b, c, S, D3), dist(b, d, S, D4), D3 < D4.
dist(A, B, S, D) :- nth0(IA, S, A), nth0(IB, S, B), D is abs(IA-IB).

%2
princess(S) :- S=[_,_], member(p,S), member(t,S), l3(S).
l1(S) :- S=[p,t].
l2(S) :- S=[p,t].
l2(S) :- S=[t,p].
l3(S) :- l1(S), not(l2(S)).
l3(S) :- not(l1(S)), l2(S).



