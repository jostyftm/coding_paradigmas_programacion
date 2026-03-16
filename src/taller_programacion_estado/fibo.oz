functor
import
   System
   Application
define
   local Fibonacci Resultado in

      % Función iterativa de Fibonacci usando celdas
      fun {Fibonacci N}
         % Caso base según el enunciado
         if N < 2 then 1
         else
            local A B Iterador Temp in
               % Inicializamos las celdas con los valores de fib(0) y fib(1)
               A = {NewCell 1}
               B = {NewCell 1}
               % Empezamos a iterar desde 2 hasta N
               Iterador = {NewCell 2}
               Temp = {NewCell 0}

               for while:(@Iterador =< N) do
                  % Calculamos el siguiente número
                  Temp := @A + @B
                  % Desplazamos los valores: el actual pasa a ser el anterior
                  A := @B
                  B := @Temp
                  
                  % Incrementamos el contador
                  Iterador := @Iterador + 1
               end

               % El resultado final queda en la celda B
               @B
            end
         end
      end

      % Ejecutamos una prueba: fib(5)
      % Secuencia: fib(0)=1, fib(1)=1, fib(2)=2, fib(3)=3, fib(4)=5, fib(5)=8
      Resultado = {Fibonacci 5}

      % Imprimimos en consola
      {System.show Resultado}

      % Apagado de la máquina virtual
      {Application.exit 0}
   end
end

% ozc -c fibo.oz
% ozengine fibo.ozf