functor
import
   System
   Application
define
   local Filter Gen Sieve Primes ShowPrimes in
      
      % 1. Filtro Perezoso
      fun lazy {Filter Xs F}
         case Xs
         of nil then nil
         [] X|Xr then
            if {F X} then X | {Filter Xr F}
            else {Filter Xr F} end
         end
      end

      % 2. Generador Perezoso
      fun lazy {Gen I}
         I | {Gen I+1} 
      end

      % 3. Criba de Eratóstenes Perezosa
      fun lazy {Sieve Xs}
         case Xs 
         of X|Xr then
            % CORRECCIÓN: Usamos \= (el operador nativo de Mozart 1.4.0)
            X | {Sieve {Filter Xr fun {$ Y} (Y mod X) \= 0 end}}
         end
      end

      % 4. Flujo infinito de números primos
      fun lazy {Primes}
         {Sieve {Gen 2}} 
      end

      % 5. Consumidor estricto
      proc {ShowPrimes N}
         local
            fun {Take L C}
               if C == 0 then nil
               else 
                  case L 
                  of X|Xr then X | {Take Xr C-1} 
                  end
               end
            end
         in
            {System.show {Take {Primes} N}} 
         end
      end

      % ---------------------------------------------------------
      % EJECUCIÓN
      % ---------------------------------------------------------
      {System.showInfo "Calculando los primeros 15 numeros primos..."}
      
      {ShowPrimes 15}
      
      {Application.exit 0}
      
   end
end

% ozc -c primosPereza.oz
% ozengine primosPereza.ozf