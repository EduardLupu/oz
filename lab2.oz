%Execise 1 Combinations of N taken K at a time

% a) Combinations of N taken K at a time

declare
fun {CalculateNumerator N K}
   if K == 0 then
      1
   else
      N * {CalculateNumerator N-1 K-1}
   end
end

%{Browse {CalculateNumerator 10 3}}
%{Browse {CalculateNumerator 5 5}}
%{Browse {CalculateNumerator 3 2}}

declare
fun {CalculateNumitor K}
   if K == 0 then
      1
   else
      K * {CalculateNumitor K-1}
   end
end

%{Browse {CalculateNumitor 3}}
%{Browse {CalculateNumitor 5}}
%{Browse {CalculateNumitor 2}}


declare
fun {Combinations N K}
   {CalculateNumerator N K} div {CalculateNumitor K}
end

%{Browse {Combinations 10 3}}
%{Browse {Combinations 5 5}}
%{Browse {Combinations 3 2}}

% b) Combinations of N taken K at a time

declare
fun {CombinationsMethod2 N K}
   if K == 0 then
      1
   else
      {FloatToInt {IntToFloat N-K+1} / {IntToFloat K} * {IntToFloat {CombinationsMethod2 N K-1}}}
   end
end

%{Browse {CombinationsMethod2 10 3}}
%{Browse {CombinationsMethod2 5 5}}
%{Browse {CombinationsMethod2 3 2}}

% Execise 2. Reverse list, prolog style without using Append calls

declare
fun {Reverse L R}
    case L
        of nil then R
   [] H|T then {Reverse T H|R}
   end
end

%{Browse {Reverse [1 2 3] nil}}
%{Browse {Reverse ['I' 'WANT' 2 go] nil}}

% Exercise 3. Generate a list of prime numbers, using lazy evaluation and create GetAfter function

declare
fun lazy {Filter L H}
    case L of
        nil then nil
        [] A|As then
        if A mod H == 0 then
            {Filter As H}
        else
            A|{Filter As H}
        end
    end
end

declare
fun lazy {Sieve L}
    case L of
        nil then nil
        [] H|T then H|{Sieve {Filter T H}}
   end
end

declare
fun lazy {Gen N}
    N|{Gen N+1}
end

declare
fun lazy {Prime}
    {Sieve {Gen 2}}
end

declare
fun {Check N L}
    case L of
        H|T then
        if H > N then
            H
        else
            {Check N T}
        end
    end
end

declare
fun {GetAfter N}
    {Check N {Prime}}
end

%{Browse {GetAfter 1}}
%{Browse {GetAfter 2}}
%{Browse {GetAfter 30}}
%{Browse {GetAfter 99}}


declare
fun {Insert T N}
    if T == nil then
        bst(node: N right: nil left:nil)
    elseif T.node < N then
        bst(node: T.node left: T.left right: {Insert T.right N})
    else 
        bst(node: T.node left: {Insert T.left N} right: T.right)
    end
end

declare
Y = nil
E1 = 5
E2 = 10
E3 = 60
E4 = 25
X = bst(node:10 left: bst(node:3 left: nil right:nil) right: bst(node: 30 left: nil right: nil))
%{Browse {Insert {Insert {Insert {Insert X E1 } E2 } E3 } E4 }}

declare
fun {Smallest T}
    if T.left == nil then
        T.node
    else 
        {Smallest T.left}
   end
end

declare
X2 = bst(node: 10 left: bst(node: 9 left: bst(node: 3 left: nil right: nil) right: bst(node: 40 left: nil right: nil)) right: 50)
{Browse {Smallest X2}}

declare
fun {Biggest T}
    if T.right == nil then
        T.node
    else
        {Biggest T.right}
    end
end

declare
X3 = bst(node: 10 left: 5 right: bst(node: 20 left: nil right: bst(node: 100 left: nil right: nil)))

%{Browse {Biggest X3}}

declare
fun {IsSorted T}
    if T == nil then
        true
    elseif {And T.left == nil T.right == nil} then
        true
    elseif {And T.left == nil T.node < T.right.node} then
        {IsSorted T.right}
    elseif {And T.left == nil T.node > T.right.node} then
        false
    elseif {And T.right == nil T.node >= T.left.node} then
        {IsSorted T.left}
    elseif {And T.right == nil T.node < T.left.node} then 
        false
    elseif {And T.node >= T.left.node T.node < T.right.node} then 
        {And {IsSorted T.left} {IsSorted T.right}}
    else 
        false
    end
end

declare
X4 = bst(node: 20 left: bst(node: 10 left: nil right: nil) right: bst(node: 15 left: 23 right: bst(node: 30 left: nil right: bst(node: 40 left: nil right: nil))))
X5 = bst(node: 20 left: bst(node: 10 left: nil right: nil) right: bst(node: 30 left: nil right: nil))
X6 = bst(node: 20 left: bst(node: 10 left: nil right: nil) right: bst(node: 25 left: bst(node:23 left: nil right: nil) right: bst(node: 30 left: nil right: bst(node: 21 left: nil right: nil))))
{Browse {IsSorted X5}}
