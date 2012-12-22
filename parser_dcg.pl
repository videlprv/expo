%%% what excercise tells: 
%atom_separated --> atom, ")".
%tom_separated --> atom, "(".
%atom_separated --> atom, " ".
%atom_separated --> atom, "\r"
%atom_separated --> atom, "\t"

%%% what author (possibly) meaned:
atom_separated --> "(", atom, ")",!.
atom_separated --> atom, sep,!.

%%% EBNF (extended Backus-Naur orm) transformated to DCG (Definite Clause Grammar)
lisp_program --> s_expression_star.

s_expression_star --> s_expression, s_expression_star.
s_expression_star --> [].

s_expression --> list,!.
s_expression --> "(", sep_star, s_expression, sep_star, ".",  sep_star, s_expression, sep_star, ")",!.
s_expression --> atom.

list --> "(", sep_star, s_expression, seq_s_expression, sep_star, ")".

seq_s_expression --> sep_star, s_expression, sep_plus, seq_s_expression.
seq_s_expression --> sep_star, s_expression.

atom --> letter,atom_part,!.
atom --> letter. 

atom_part --> letter, atom_part, !.
atom_part --> digit, atom_part, !.
atom_part --> letter.
atom_part --> digit.

letter --> [L], {is_alpha(L)}.
digit  --> [D], {is_digit(D)}.

set_plus --> sep.

sep_star --> sep.
sep_star --> [].

sep --> " ",  sep.
sep --> "\n", sep.
sep --> "\t", sep.
sep --> "\r", sep. 
sep --> " ".
sep --> "\n".
sep --> "\t".
sep --> "\r".
%%% example LISP one-liner.
%(defun negate (X) "Negate the value of X." (- X))  

%%% smarter:
%sep --> [S], {is_white(S)}.
%sep --> [S], {is_endline(S)}.
%sep --> [S], sep, {is_white(S)}.
%sep --> [S], sep, {is_endline(S)}.


