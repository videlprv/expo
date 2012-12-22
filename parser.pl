% notes:
%%% add cut after each clause body to make parser valid.
%%%
%%% 'maximal munch' parser (see http://en.wikipedia.org/wiki/Maximal_munch).
%%% Grammar used in excercise text is actually in EBNF (extended Backus-Naur form). BNF doesn't permit *.
%%% More over event treated as EBNF it still has some itches and scratches. The sep+ is redundant, 
%%% as sep set of productions already forces it to be non-empty.
 
s_expr(L, Reminder) :- list(L,Reminder),!.
s_expr(L, Reminder) :- left_par(L,R1), sep_star(R1,R2), s_expr(R2,R3), sep_star(R3,R4),
                       dot(R4,R5),     sep_star(R5,R6), s_expr(R6,R7), sep_star(R7,R8), right_par(R8,Reminder),!. 
s_expr(L, Reminder) :- atom(L,Reminder),!.

list(L,Reminder) :- left_par(L,R1), sep_star(R1,R2), s_expr(R2,R3), seq_s_expr(R3,R4), sep_star(R4,R5), 
                    right_par(R5,Reminder),!.

seq_s_expr(L,Reminder) :- sep_star(L,R1), s_expr(R1, R2), sep_plus(R2,R3), seq_s_expr(R3,Reminder),!.
seq_s_expr(L,Reminder) :- sep_star(L,R1), s_expr(R1, Reminder),!.

atom_sep(L,Reminder) :- left_par(L,LeftParRM), atom_part(LeftParRM, AtomRM), right_par(AtomRM, Reminder),!.
atom_sep(L,Reminder) :- atom_part(L, AtomRM), sep(AtomRM, Reminder),!.

atom(L,Reminder) :- letter(L,LetterRM), atom_part(LetterRM, Reminder),!.
atom(L,Reminder) :- letter(L,Reminder),!.

atom_part(L, Reminder) :- letter(L, LetterRM), atom_part(LetterRM, Reminder),!.
atom_part(L, Reminder) :- digit(L, DigitRM), atom_part(DigitRM, Reminder),!.
atom_part(L, Reminder) :- letter(L, Reminder),!.
atom_part(L, Reminder) :- digit(L, Reminder),!.

digit([H|R], R) :- is_digit(H).

letter([H|R], R) :- is_alpha(H).

sep_star(L,R) :- sep(L,R),!.
sep_star(R,R).

sep_plus(L,R) :- sep(L,R).

sep([H|L],R) :- is_newline(H), sep(L,R),!.
sep([H|L],R) :- is_white(H),   sep(L,R),!.
sep([H|R],R) :- is_newline(H).
sep([H|R],R) :- is_white(H).

%%% naturally, following could be amalgamated into preciding clauses, 
%%% however this approach seems to be more clear to me.  

left_par([40|R],R).  % 40 == '('

right_par([41|R],R). % 41 == ')'

dot([46|R],R).       % 46 == '.'

%%% other solutions?