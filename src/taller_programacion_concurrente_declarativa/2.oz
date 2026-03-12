functor
import
   System
define
   local Filter Sal A in
      
      % Definición de la función Filter
      fun {Filter En F}
         case En
         of X|En2 then
            if {F X} then X|{Filter En2 F}
            else {Filter En2 F} end
         else
            nil
         end
      end

      % Hilo 1: Ejecuta el filtro
      thread 
         Sal = {Filter [5 1 A 4 0] fun {$ X} X>2 end} 
      end
      
      % Hilo 2: Asigna el valor a la variable libre A
      thread 
         A = 6 
      end
      
      % El hilo principal espera 1 segundo
      {Delay 1000}
      
      % Se muestra el resultado
      {System.show Sal}
      
   end
end