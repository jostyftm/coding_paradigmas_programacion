functor
import
   System
   Application
define
   local NotGate AndGate OrGate Simulate Circuito Entradas Resultado in
      
      fun {NotGate Xs}
         case Xs of X|Xr then (1-X) | {NotGate Xr} [] nil then nil end
      end

      fun {AndGate Xs Ys}
         case Xs#Ys of (X|Xr)#(Y|Yr) then (X*Y) | {AndGate Xr Yr} [] nil#nil then nil end
      end

      fun {OrGate Xs Ys}
         case Xs#Ys of (X|Xr)#(Y|Yr) then (X+Y - X*Y) | {OrGate Xr Yr} [] nil#nil then nil end
      end

      fun {Simulate G Ss}
         case G
         of gate(value:'not' input(X)) then
            {NotGate {Simulate input(X) Ss}}
         [] gate(value:'and' G1 G2) then
            {AndGate {Simulate G1 Ss} {Simulate G2 Ss}}
         [] gate(value:'or' G1 G2) then
            {OrGate {Simulate G1 Ss} {Simulate G2 Ss}}
         [] input(X) then Ss.X
         end
      end

      % Datos de prueba
      Entradas = inputs(x:[0 1 0 1] y:[0 0 1 1])
      Circuito = gate(value:'and' input(x) input(y))
      
      % Ejecución
      Resultado = {Simulate Circuito Entradas}
      
      {System.show Resultado}
      {Application.exit 0}
      
   end
end

% ozc -c logicaDigital.oz
% ozengine logicaDigital.ozf