functor
import
   System
   Application
define
   local L2 L3 L4 in
      
      % ---------------------------------------------------------
      % SIMULACIÓN DEL "CÓDIGO PREVIO"
      % Lanzamos tres cálculos concurrentes que toman diferentes tiempos
      % ---------------------------------------------------------
      {System.showInfo "Iniciando calculos en segundo plano..."}
      
      thread 
         {Delay 1000} % Tarda 1 segundo
         L2 = 100 
      end
      
      thread 
         {Delay 3000} % Tarda 3 segundos (el más lento)
         L3 = 200 
      end
      
      thread 
         {Delay 500}  % Tarda medio segundo
         L4 = 300 
      end

      % ---------------------------------------------------------
      % TU CÓDIGO DE SINCRONIZACIÓN
      % ---------------------------------------------------------
      {System.showInfo "El hilo principal esta esperando (sincronizando)..."}
      
      {Wait L2}
      {Wait L3}
      {Wait L4}
      
      % Una vez que todos los 'Wait' son superados, mostramos la tupla
      {System.showInfo "Todos los hilos terminaron. Resultado:"}
      {System.show L2#L3#L4}
      
      % Cerramos la máquina virtual limpiamente
      {Application.exit 0}
      
   end
end

% ozc -c terminacion.oz
% ozengine terminacion.ozf