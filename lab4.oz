%Problem 1 - Free variables

declare
fun {Concat L1 L2}
   	case L1 of
      		nil then L2
   		[] H|T then H|{Concat T L2}
   	end
end


fun {Find L X}
    	case L of 
      		nil then false
      		[] H|T then 
            		if H == X then true 
           		 else {Find T X} 
           	 end
      	end
end


declare
fun {FreeSetAux Exp L}
   	case Exp of
      		apply(Exp1 Exp2) then 
            		{Concat {FreeSetAux Exp1 L} {FreeSetAux Exp2 L}}
      
      	[] lam(ID Exp1) then 
            	{FreeSetAux Exp1 ID|L}
      
      	[] let(ID#Exp1 Exp2) then 
            	{Concat {FreeSetAux Exp1 ID|L} {FreeSetAux Exp2 ID|L}}
      
      	[] ID then
            	if {Find L ID} then nil 
           	else [ID] 
           	end
   	end
end


fun {FreeSet Exp}
    {FreeSetAux Exp nil}
end


%{Browse {FreeSet apply(x let(x#y x))} == [x y]}
%{Browse {FreeSet apply(y apply(let(x#x x) y))} == [y y]}
%{Browse {FreeSet lam(x apply(y x))} == [y]}

%Problem 2 - Environment/Mapping

declare
fun {IsMember Env ID}
   	case Env of
      		nil then false
      		[] A#B|T then 
            		if ID == A then true 
            		else {IsMember T ID} 
            		end
      	end
end


declare
fun {Fetch Env ID}
   	case Env of
      		nil then ID
   		[]  A#B|T then 
        		if ID == A then B 
        		else {Fetch T ID} 
        		end
   	end
end


declare
fun {AdjoinAux Env Exp}
   	case Env of
      		nil then nil
   	[] A#B|T then
      		case Exp of
       			X#Y then 
            		if A == X then {AdjoinAux T Exp}
            		else (A#B)|{AdjoinAux T Exp} 
            		end
        	end	 
   	end
end

declare
fun {Adjoin Env Exp}
   Exp | {AdjoinAux Env Exp}
end


%{Browse {IsMember [a#e1 b#y c#e3] c} == true}
%{Browse {IsMember [a#e1 b#y c#e3] y} == false}
%{Browse {Fetch [a#e1 b#y c#e3] c} == e3}
%{Browse {Fetch [a#e1 b#y c#e3] d} == d}
%{Browse {Adjoin [a#e1 b#y c#e3] c#e4} == [c#e4 a#e1 b#y]}
%{Browse {Adjoin [a#e1 b#y c#e3] d#e4} == [d#e4 a#e1 b#y c#e3]}

   declare
Cnt={NewCell 0}


fun {NewId}
   	Cnt:=@Cnt+1
   	{String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end


declare
fun {RenameAux Exp Env}
   	if {IsAtom Exp} then 
     		if {IsMember Env Exp} then {Fetch Env Exp} 
      		else Exp 
      		end
   	else
   		case Exp of
   			nil then nil
   
   			[] apply(Exp1 Exp2) then 
         			apply({RenameAux Exp1 Env} {RenameAux Exp2 Env})
   
   			[] lam(ID Ex) then
         			if {IsMember Env ID} then lam({Fetch Env ID} {RenameAux Ex Env})
         			else local Envs in
              				Envs = {Adjoin Env ID#{NewId}}
               				lam({Fetch Envs ID} {RenameAux Ex Envs})
            				end
         			end  
   
   			[] let(ID#Exp1 Exp2) then
         			if {IsMember Env ID} then
            				let({Fetch Env ID}#{RenameAux Exp1 Env} {RenameAux Exp2 Env})
         			else local Envs in
               				Envs = {Adjoin Env ID#{NewId}}
               				let({Fetch Envs ID}#{RenameAux Exp1 Envs} {RenameAux Exp2 Envs})
            				end
         			end  
   			end
   		end
end


fun {Rename E}
   {RenameAux E nil}
end


%{Browse {Rename lam(z lam(x z))} == lam('id<1>' lam('id<2>' 'id<1>'))}
%{Browse {Rename let(id#lam(z z) apply(id y))} == let('id<3>'#lam('id<4>' 'id<4>') apply('id<3>' y))}

declare
fun {ReplaceIn Exp ID NewId}
   	case Exp of 
   		nil then Exp
   
   		[] let(Left#Right Result) then
        		let({ReplaceIn Left ID NewId}#{ReplaceIn Right ID NewId} {ReplaceIn Result ID NewId})
   
   		[] lam(T Body) then
        		lam({ReplaceIn T ID NewId} {ReplaceIn Body ID NewId})
   
   		[] apply(Left Right) then
        		apply({ReplaceIn Left ID NewId} {ReplaceIn Right ID NewId})
   
   		[] T then 
        		if T == ID then NewId 
        		else T 
        		end
   	end
end


fun {Subs Binding InExp}
    	case Binding of 
    		nil then nil
    		[] Id#Exp then
        	{ReplaceIn {Rename InExp} Id Exp}
    end
end


%{Browse {Subs x#lam(x x) apply(x y)} == apply(lam(x x) y)}
%{Browse {Subs x#lam(z z) apply(x lam(x apply(x z)))} == apply(lam(z z) lam('id<5>' apply('id<5>' z)))}
