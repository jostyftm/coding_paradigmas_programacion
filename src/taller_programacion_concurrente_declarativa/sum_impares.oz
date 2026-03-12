functor
import
   System
   Application % 1. Importamos el módulo para controlar el ciclo de vida de la app
define
   local Productor FiltroImpares Consumidor Flujo NumerosImpares Total in
      
      fun {Productor N Max}
         if N > Max then nil
         else N | {Productor N + 1 Max} end
      end

      fun {FiltroImpares Xs}
         case Xs
         of nil then nil
         [] X|Xr then
            if (X mod 2) == 0 then {FiltroImpares Xr}
            else X | {FiltroImpares Xr} end
         end
      end

      fun {Consumidor Xs}
         fun {Sumar Ls Acc}
            case Ls
            of nil then Acc
            [] X|Xr then {Sumar Xr Acc + X}
            end
         end
      in
         {Sumar Xs 0}
      end

      % Ejecución del flujo
      Flujo = {Productor 1 10000}
      NumerosImpares = {FiltroImpares Flujo}
      Total = {Consumidor NumerosImpares}
      
      % Imprimir en consola
      {System.show Total}
      
      % 2. INSTRUCCIÓN DE CIERRE: Apaga la máquina virtual y libera la RAM
      {Application.exit 0}
      
   end
end

% ozc sum_impares.oz
% ozengine sum_impares.oz