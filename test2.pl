% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

present(X,tree(X,_,_)).
present(X,tree(_,LT,_)):- inserting(X,LT).
present(X,tree(_,_,RT)):- inserting(X,RT).


inserting(X,null,tree(X,null,null)).
inserting(X,tree(K,LT,RT),tree(K,NLT,RT)) :- X>K ,
    inserting(X,LT,NLT).
inserting(X,tree(K,LT,RT),tree(K,LT,NRT)) :- X<K ,
    inserting(X,RT,NRT).

add(null,S) :- S is 0.
add(tree(K,LT,RT), S) :- add(LT,S1),add(RT,S2), S is K+S1+S2.




count_leaves(null,Count) :- Count is 0.
count_leaves(tree(_,null,null),1) :- !.
count_leaves(tree(_,TL,TR),C):- count_leaves(TL,C1),count_leaves(TR,C2), C is C1+C2.

compute(null,0).
compute(tree(Key,null,null),Key).
compute(tree(+,LT,RT),R):- compute(LT,R1),compute(RT,R2) , R is R1+R2.
compute(tree(-,LT,RT),R):- compute(LT,R1),compute(RT,R2) , R is R1-R2.
compute(tree(*,LT,RT),R):- compute(LT,R1),compute(RT,R2) , R is R1*R2.
compute(tree(/,LT,RT),R):- compute(LT,R1),compute(RT,R2) , R is R1/R2.

converting(A,tree(A,null,null)) :- number(A).
converting(A+B,tree(+,LT,RT)):- converting(A,LT),converting(B,RT).

converting(A-B,tree(-,LT,RT)):- converting(A,LT),converting(B,RT).

converting(A*B,tree(*,LT,RT)):- converting(A,LT),converting(B,RT).

converting(A/B,tree(/,LT,RT)):- converting(A,LT),converting(B,RT).


inaltime(null,0).
inaltime(tree(_,LT,RT),H):- inaltime(LT,H1),inaltime(RT,H2),H is max(H1,H2)+1.

nod_arborebin(t(_,null,null),1).
nod_arborebin(t(_,S,null),N):-
    nod_arborebin(S,N1),N is N1+1.

nod_arborebin(t(_,null,D),N):-
    nod_arborebin(D,N1),N is N1+1.
nod_arborebin(t(_,S,D),N) :- nod_arborebin(S,N1),nod_arborebin(D,N2),N is 1+N1+N2.


getNewLRoot(tree(Key,_,null),Key).
getNewLRoot(tree(Key,_,RightSubTree),NewRoot):-atomic(Key),getNewLRoot(RightSubTree,NewRoot).
getNewRRoot(tree(Key,null,_),Key).
getNewRRoot(tree(Key,LeftSubTree,_),NewRoot):-atomic(Key),getNewLRoot(LeftSubTree,NewRoot).
removing(Key,tree(Key,null,null),null).
removing(Key,tree(Root, LeftSubTree,RightSubTree),tree(Root,NewLeftSubTree,RightSubTree)) :- Key<Root,removing(Key,LeftSubTree,NewLeftSubTree).
removing(Key,tree(Root,LeftSubTree,RightSubTree),tree(Root,LeftSubTree,NewRightSubTree)) :- Key>Root,removing(Key,RightSubTree,NewRightSubTree).
removing(Key,tree(Key,LeftSubTree,RightSubTree),tree(NewRoot,NewLeftSubTree,RightSubTree)):-getNewLRoot(LeftSubTree,NewRoot),removing(NewRoot,LeftSubTree,NewLeftSubTree).
removing(Key,tree(Key,LeftSubTree,RightSubTree),tree(NewRoot,LeftSubTree,NewRightSubTree)):-getNewRRoot(RightSubTree,NewRoot),removing(NewRoot,RightSubTree,NewRightSubTree).

inorder(tree(K,null,null)):-write(K).
inorder(null).
inorder(tree(K,L,R)):- inorder(L),
                   write(K),
               inorder(R).
preorder(tree(Root,null,null)) :- write(Root),!.
preorder(null).
preorder(tree(Root,LeftSubTree,RightSubTree)) :- write(Root),preorder(LeftSubTree),preorder(RightSubTree).

postorder(tree(Root,null,null)) :- write(Root),!.
postorder(null).
postorder(tree(Root,LeftSubTree,RightSubTree)) :- postorder(LeftSubTree),postorder(RightSubTree),write(Root).

% symetrical(null,null).
% symetrical(tree(K1,L1,R1),tree(K2,L2,R2)):-
                   %          K1 = K2,
                     %        symetrical(L1,R2),
                % symetrical(L2,R1) .

%inserting(X,[],[X]).
%inserting(X,[H|T],R) :- append([X],[H],H1), append(H1,T,R).
%inserting(X,[H|T],R) :- inserting(X,T,R1),append([H],R1,R).

deleting_one(X,[X],[]).
deleting_one(X,[X|T],T).
deleting_one(X,[H|T],R) :- deleting_one(X,T,R1), append([H],R1,R),!.


deleting_all(X,[X],[]).
deleting_all(X,[X|T],R):- deleting_all(X,T,R).
deleting_all(X,[H|T],R):- deleting_all(X,T,R1), append([H],R1,R),!.

range(A,A,[A]).
range(A,B,[A|T]):- A1 is A+1, range(A1,B,T),!.

rotate([A],1,[A]).
rotate([H|T],1,[H1|T1]):- rotate(T,1,[H1|T2]),append([H],T2,T1),!.
rotate(L,N,L1) :- rotate(L,1,L2), N1 is N-1, N1>0, rotate(L2,N1,L1).

flatten_list([A],[A]).
flatten_list([H|T],R) :- is_list(H), flatten_list(H,R1), flatten_list(T,R2), append(R1,R2,R).
flatten_list([H|T],R) :- flatten_list(T,R1), append([H],R1,R).


inverting([A],[A]):- !.
inverting([H|T],[H1|T1]) :- inverting(T,[H1|T2]), append(T2,[H],T1).

duplicate([], []) :- !.
duplicate([H|T], [H1|T1]) :- H1 = [H, H], duplicate(T, T1).


predecessors(Item,EntireList,ListOfPredecessors) :-
    append(ListOfPredecessors,[Item|_],EntireList).

successors(Item,EntireList,ListOfSuccessors) :-
    append(_,[Item|ListOfSuccessors],EntireList).


reverting(List, K1, K2, Result):- member(K1, List),
	member(K2, List),
	predecessors(K1, List, Pre),
	successors(K2,List,Suc),
	successors(K1, List, Ls),
	predecessors(K2, Ls, L),
	inverting(L,Res),
	append(Pre,[K2],Pre1),
	append(Pre1,Res, R1),
	append(R1,[K1],S1),
	append(S1,Suc,Result).

last-item([],_):-fail.
last-item([H|[]],H).
last-item([_|T],I):-last-item(T,I).

palindrome(L) :- my_reverse(L,L).
my_reverse(L1,L2) :- my_rev(L1,L2,[]).
my_rev([],L2,L2) :- !.
my_rev([X|Tail],L2,NewList) :- my_rev(Tail,L2,[X|NewList]).



sortlist([],[]).
sortlist([H|T],SL):-
  sortlist(T,SL1),
  insord(H,SL1,SL).

insord(Item,[],[Item]).
insord(Item,[H|T],L):-
  Item > H,
  insord(Item,T,L1),
  append([H],L1,L),!.
insord(Item,[H|T],L):-
  append([Item],[H],L1),
  append(L1,T,L),!.


:- arithmetic_function(added_with/2).
:- op(500,yfx,added_with).
added_with(X,Y,Z) :-
Z is X+Y.
test(X) :-
X is 3 added_with 4 added_with 5.


:- op(300,xfx,plays).
:- op(200,xfy,and).
jimmy plays football and basketball and tennis.

:- op(300,xf,was).
:- op(400,xfy,of).
:- op(200,yfx,the).
john was the secretary of the department.

:-op(300,fy, deleting).
:-op(400,yfx,from).
:-op(200,xfx, gives).
deleting X from L1 gives L2:- delete(L1,X,L2).

:- op(500, fy, and).
:- op(350, xfy, concatenating).
:- op(300, xf, gives).

concatenating L1 and L2 and L3 and L4 gives L :- append(L1,L2,L5),append(L3,L4,L7), append(L5, L7, L), !.
concatenating L1 and L2 gives L :- append(L1, L2, L),!.
concatenating L gives L.

square :- writef('Enter a number: '), read(X), Y is X*X, writef('%d^2 = %d\n', [X, Y]), square.

writelist([]).
writelist([H|T]) :- writef('%d ', [H]), writelist(T).

:- op(500, fx, intersecting).
:- op(400, xfx, with).
:- op(300, xfy, gives).

intersecting List1 with List2 gives List3 :- intersection(List1, List2, List3).

:- op(300, fx, '{').
:- op(200, xfx, '..').
:- op(300, xf, '}').

intersecting {A..B} with {C..D} gives {E..F} :- B >= C,
	E is max(A,C),
	F is min(B,D), !.
intersecting {_.._} with {_.._} gives What :- What = void, !.





:- op(500, xfx, copy).

_ copy _ :- open('input.txt', read, In),
	open('output.txt',write,Out),
	copyByte(In, Out),
	close(Out),
	close(In).

copyByte(In, Out) :- get_byte(In, B),
	(   B == -1, !;
	put_byte(Out,B),
	copyByte(In,Out)).
element(X,[X|T],T).
element(X,[_|T],R):-element(X,T,R).
combinatii(0,_,[]).
combinatii(K,L,[X|Xs]):-K>0,
	element(X,L,R),
	K1 is K-1,
	combinatii(K1,R,Xs).

scrie([],_,_).
scrie([H|T],A,N):-
	write(H), write(' '),
	A1 is A+1,
	A1<N,scrie(T,A1,N);
	scrie1(T,N,N).
scrie1([],N,N).
scrie1(List,N,N):-
	nl,
	N1 is N+1,
	scrie(List,0,N1).
piramida(List):-scrie(List,0,1).
