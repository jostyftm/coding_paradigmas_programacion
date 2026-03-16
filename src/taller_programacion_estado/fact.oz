functor
import
   System
   Application
define
   local Factorial Resultado in

      % Función que calcula N! utilizando estado explícito
      fun {Factorial N}
         local Acumulador Iterador in
            % Inicializamos las celdas en 1
            Acumulador = {NewCell 1}
            Iterador = {NewCell 1}

            % Bucle iterativo hasta llegar a N
            for while:(@Iterador =< N) do
               % Multiplicamos el valor actual por el iterador
               Acumulador := @Acumulador * @Iterador
               % Incrementamos el iterador en 1
               Iterador := @Iterador + 1
            end

            % Retornamos el valor almacenado en la celda Acumulador
            @Acumulador
         end
      end

      % Ejecutamos una prueba (Ejemplo: 5! = 120)
      Resultado = {Factorial 5}

      % Imprimimos el resultado en la consola
      {System.show Resultado}

      % Apagamos la máquina virtual limpiamente
      {Application.exit 0}
   end
end

% ozc -c fact.oz
% ozengine fact.ozf