% Seminar 3

% Exercise 1 - (Finding an Element in a List) 
% Give a definition of {Member Xs Y} that tests whether Y is an element of Xs. 
% For this assignment you have to use the truth values true and false. The equality test (that is ==) returns truth values and a function returning truth values can be used as condition in an if-expression.
% For example, the call {Member [a b c] b} should return true, whereas {Member [a b c] d} should return false.

declare
fun {FindElementInList L E}
   case L
   of nil then false
   [] H|T then if H == E then
		  true
	       else
		  {FindElementInList T E}
	       end
   end
end

{Browse {FindElementInList [a b c] b}}
{Browse {FindElementInList [a b c] d}}


% Exercise 2 - Take the first N elements of out an list
% (Taking and Dropping Elements) Write two functions {Take Xs N} and
% {Drop Xs N}. The call {Take Xs N} returns the first N elements of Xs whereas the call {Drop Xs N} returns Xs without its first N elements. 
% For example, {Take [1 4 3 6 2] 3} returns [1 4 3] and {Drop [1 4 3 6 2] 3} returns [6 2].

declare
fun {Take L N}
   if N == 0 then
      nil
   else
      case L
      of nil then nil
      [] H|T then H|{Take T N-1}
      end
   end
end

%{Browse {Take [1 4 3 6 2] 3}}
%{Browse {Take [1 2 3] 4}}

declare
fun {Drop L N}
   case L
   of nil then nil
   [] H|T then if N > 0 then
		  {Drop T N - 1}
	       else
		  H| {Drop T N}
	       end
   end
end

%{Browse {Drop [1 4 3 6 2] 3}}
%{Browse {Drop [1 2] 4}}


% Exercise 3 - Zip And UnZip
% (Zip and UnZip) The operation a # b constructs a tuple with label ’#’ and fields a and b which is also known as a pair. We can use it to implement lists-of-pairs,
% e.g [a#1 b#2 c#3]. A different view of this data structure is known as a pair-of-lists, e.g
% [a b c]#[1 2 3]. Two important functions that convert list-of-pairs to pair-of-lists and vice versa are Zip and UnZip.

declare
A = [a b c]
B = [1 2 3]
X = A#B

{Browse X.1}
{Browse X}

% a) Implement a function Zip that takes a pair Xs#Ys of two lists Xs and Ys (of the same length) and returns a pairlist, 
% where the first field of each pair is taken from Xs and the second from Ys. For example, {Zip [a b c]#[1 2 3]} returns the pairlist [a#1 b#2 c#3].

declare
fun {Zip X}
   case X
   of nil#nil then nil
   [] (H1|T1)#(H2|T2) then H1#H2 | {Zip T1#T2}
   end
end

{Browse { Zip X}}


declare
A = [a#1 b#2 c#3]
{Browse A}

% b) The function UnZip does the inverse, for example {UnZip [a#1 b#2 c#3]}
% returns [a b c]#[1 2 3]. Give a specification and implementation of UnZip.

% Specification: 
% UnZip : list (A # B) → (list A) # (list B)
% UnZip(nil) = nil # nil
% UnZip((H1 # H2) | T) = (H1 | Y) # (H2 | Z) where (Y # Z) = UnZip(T)


declare
fun {UnZip X}
   case X
   of nil then nil#nil
   [] (H1#H2)|T then
      T1#T2 = {UnZip T} in
      (H1|T1)#(H2|T2)
   end
end


{Browse {UnZip A}}


% Exercise 4 - (Finding the Position of an Element in a List) 
% Write a function {Position Xs Y} that returns the first position of Y in the list Xs. 
% The positions in a list start with 1. For example, {Position [a b c] c} returns 3 and {Position [a b c b] b} returns 2.
% Try two versions:
% 1) one that assumes that Y is an element of Xs
% 2) one that returns 0, if Y does not occur in Xs.


% First version

declare
fun {Pos1 L E Pos}
   case L
   of nil then Pos
   [] H|T then
      if H == E then
	 Pos
      else
	 {Pos1 T E Pos + 1}
      end
   end
end


{Browse {Pos1 [a b c] c 1}}

% Second version

declare
fun {Pos2 L E Pos}
   case L
   of nil then 0
   [] H|T then
      if H == E then
	 Pos
      else
	 {Pos2 T E Pos + 1}
      end
   end
end


{Browse {Pos2 [a b d] c 0}}

% Exercise 5 

declare
X = add(int(1) mul(int(3) int(4)))

{Browse X}

declare
fun {Eval X}
   case X
   of int(E) then E
   [] add(X Y) then {Eval X} + {Eval Y}
   [] mul(X Y) then {Eval X} * {Eval Y}
   end
end


{Browse {Eval X}}
      
      
      