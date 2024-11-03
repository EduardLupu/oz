% Exercises 1, 2, and 3 with messages in a single file using virtual strings, System.showInfo, and Browse

% Exercise 1 (Absolute Value)
% Write a function Abs that computes the absolute value of a number.
% This should work for both integers and real numbers.

declare
fun {Minus X}
    ~X
end

{System.showInfo "Minus(15) = " # {Minus 15}}
{Browse {Minus 15}}

declare
fun {Max X Y}
    if X > Y then
        X
    else
        Y
    end
end

declare
fun {AbsoluteValue X}
    {Max X {Minus X}}
end

{System.showInfo "AbsoluteValue(15) = " # {AbsoluteValue 15}}
{System.showInfo "AbsoluteValue(~15) = " # {AbsoluteValue ~15}}
{System.showInfo "AbsoluteValue(5.5) = " # {AbsoluteValue 5.5}}
{System.showInfo "AbsoluteValue(~5.5) = " # {AbsoluteValue ~5.5}}

{Browse {AbsoluteValue 15}}
{Browse {AbsoluteValue ~15}}
{Browse {AbsoluteValue 5.5}}
{Browse {AbsoluteValue ~5.5}}

% Exercise 2 (Power)
% Compute n^m where n is an integer and m is a natural number.

declare
fun {Pow N M}
    if M == 0 then
        1
    else
        N * {Pow N M-1}
    end
end

{System.showInfo "Pow(3, 3) = " # {Pow 3 3}}
{System.showInfo "Pow(12, 2) = " # {Pow 12 2}}
{System.showInfo "Pow(7, 3) = " # {Pow 7 3}}
{System.showInfo "Pow(5, 0) = " # {Pow 5 0}}

{Browse {Pow 3 3}}
{Browse {Pow 12 2}}
{Browse {Pow 7 3}}
{Browse {Pow 5 0}}

% Exercise 3 (Maximum Recursively)
% Compute the maximum of two natural numbers using a recursive definition.

declare
fun {MaximumRecursively N M}
    if N == 0 then
        M
    elseif M == 0 then
        N
    else
        1 + {MaximumRecursively N-1 M-1}
    end
end

{System.showInfo "MaximumRecursively(15, 25) = " # {MaximumRecursively 15 25}}
{System.showInfo "MaximumRecursively(35, 5) = " # {MaximumRecursively 35 5}}
{System.showInfo "MaximumRecursively(5, 5) = " # {MaximumRecursively 5 5}}

{Browse {MaximumRecursively 15 25}}
{Browse {MaximumRecursively 35 5}}
{Browse {MaximumRecursively 5 5}}
