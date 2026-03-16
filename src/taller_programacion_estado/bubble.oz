functor
import
   System
   Application
define
   local BubbleSort Resultado in

      fun {BubbleSort Xs}
         local N Arr ToList Outer Inner in
            N = {Length Xs}
            
            if N == 0 then nil
            else
               % Creamos la tupla de tamaño N
               Arr = {MakeTuple array N}
               
               % Inicializamos con celdas
               {List.forAllInd Xs proc {$ I X} Arr.I = {NewCell X} end}

               % --- Bucle Interno ---
               proc {Inner J Limit}
                  if J =< Limit then
                     % EXTRAEMOS LAS CELDAS PRIMERO PARA EVITAR EL ERROR
                     local C1 C2 in
                        C1 = Arr.J
                        C2 = Arr.(J+1)
                        
                        if @C1 > @C2 then
                           local Temp = @C1 in
                              C1 := @C2
                              C2 := Temp
                           end
                        end
                     end
                     % Siguiente iteración
                     {Inner J+1 Limit}
                  else skip end
               end

               % --- Bucle Externo ---
               proc {Outer I}
                  if I < N then
                     {Inner 1 N-I}
                     {Outer I+1}
                  else skip end
               end

               % Ejecutamos el ordenamiento
               {Outer 1}
               
               % Convertimos a lista inmutable para retornar
               fun {ToList I}
                  if I =< N then @(Arr.I) | {ToList I+1}
                  else nil end
               end
               
               {ToList 1}
            end
         end
      end

      % Ejecutamos la prueba
      Resultado = {BubbleSort [5 1 4 2 8 9 3]}
      {System.show Resultado}

      {Application.exit 0}
   end
end

% ozc -c bubble.oz
% ozengine bubble.ozf