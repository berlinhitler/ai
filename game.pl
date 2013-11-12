:- ['database.pl'].

clear:-
	retractall(answer(X,Y)),
	assert(answer(start,yes)).

game:-
	clear,
	findall(Object, object_properties(Object,_),List),
	start_ask(List).

start_ask([]):-
	writeln('I cannot find the object, not in the database.'),false.

start_ask([Head|Remaining]):-
	answer(Head,_),
	start_ask(Remaining);

	object_properties(Head,Properties),
	ask_object(Properties),
	writeln(''),
	write('I guess that the film is: '),
	write(Head),
	!;

	start_ask(Remaining).

ask_object([]).
ask_object([Head|Remaining]):-
	category_properties(Head,Properties),
	ask_category(Head,Properties),
	ask_object(Remaining),!;

	answer(Head,yes),
	ask_object(Remaining),!;

	term_to_atom(Head,A),
	sub_atom(A,0,1,_,S),
	[S] \= ['-'],
	\+ answer(Head,_),
	write('Does it have the following attribute:'),
	write(Head),
	writeln('?'),
	write('(enter yes or no, followed by a period and enter)'),
	read(Ans),
	assert(answer(Head,Ans)),
	assert_negation(Head),
	answer(Head,yes),
	ask_object(Remaining),!;

	term_to_atom(Head,A),
	sub_atom(A,1,_,0,D),
	atom_to_term(D,Term,[]),
	\+ answer(Head,_),
	write('Does it have the following attribute:'),
	write(Term),
	writeln('?'),
	write('(enter yes or no, followed by a period and enter)'),
	read(Ans),
	assert(answer(Term,Ans)),
	assert_negation(Term),
	answer(Term,no),
	ask_object(Remaining),!;

	answer(Head,no),
	object_with_neg_term(Object,Head),
	start_ask(Object).

ask_category(Category,[]):-
	assert(answer(Category,yes)),
	assert_negation(Category).

ask_category(Category,[Property|Tail]):-
	answer(Property,yes),
	ask_category(Category, Tail);

	\+ answer(Property,_),
	write('Does it have the following attribute:'),
	write(Property),
	writeln('?'),
	write('(enter yes or no, followed by a period and enter)'),
	read(Ans),
	assert(answer(Property,Ans)),
	assert_negation(Property),
	answer(Property,yes),
	ask_category(Category,Tail);

	answer(Property,no),
	assert(answer(Category,no)),
	assert_negation(Category),false.


find_object(Object,Term):-	
	object_properties(Object,X),
	member(Term,X),!.

object_with_neg_term(Object,Term):-
	term_to_atom(Term,A),
	sub_atom(A,0,1,_,S),
	[S] \= ['-'],
	find_object(Object,'-'Term),!;
	term_to_atom(Term,A),
	sub_atom(A,1,_,0,D),
	atom_to_term(D,K,[]),
	find_object(Object,K).


assert_negation(Property):-
	term_to_atom(Property,A),
	sub_atom(A,0,1,_,S),
	[S] \= ['-'],
	answer(Property,yes),
	\+answer('-'Property,no),
	assert(answer('-'Property,no)),!;

	term_to_atom(Property,A),
	sub_atom(A,0,1,_,S),
	[S] \= ['-'],
	answer(Property,no),
	\+answer('-'Property,yes),
	assert(answer('-'Property,yes)),!;

	term_to_atom(Property,A),
	sub_atom(A,1,_,0,D),
	atom_to_term(D,K,[]),
	answer(Property,yes),
	\+answer(K,no),
	assert(answer(K,no)),!;

	term_to_atom(Property,A),
	sub_atom(A,1,_,0,D),
	atom_to_term(D,K,[]),
	answer(Property,no),
	\+answer(K,yes),
	assert(answer(K,yes)),!.