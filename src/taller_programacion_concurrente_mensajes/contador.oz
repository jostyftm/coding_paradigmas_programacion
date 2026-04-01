functor
import
   System
   Application
define
   % Función que actualiza la lista de conteos
   fun {UpdateCount Char State}
      case State
      of (C#N)|T then
         if C == Char then (C#(N+1))|T
         else (C#N)|{UpdateCount Char T} end
      [] nil then [Char#1]
      end
   end

   local P S ServerLoop in
      {NewPort S P} % P es el Puerto (entrada), S es el Flujo (salida)
      
      % Hilo del Servidor
      proc {ServerLoop Stream State}
         case Stream of Char|T then
            local NewState = {UpdateCount Char State} in
               {System.showInfo "-> Servidor proceso la letra: "#Char}
               {System.show NewState}
               {ServerLoop T NewState} % Llamada recursiva con el nuevo estado
            end
         [] nil then skip
         end
      end
      
      % Levantamos el servidor en segundo plano
      thread {ServerLoop S nil} end
      
      % --- SIMULACIÓN DE CLIENTES CONCURRENTES ---
      {System.showInfo "Iniciando clientes..."}
      
      % Cliente 1: Envía 'a', espera un poco, envía 'c'
      thread {Send P a} {Delay 500} {Send P c} end 
      
      % Cliente 2: Envía 'b', espera un poco, envía 'c'
      thread {Send P b} {Delay 300} {Send P c} end 
      
      % Cliente 3: Envía 'a'
      thread {Send P a} end            
      
      % Esperamos 2 segundos a que todos terminen y apagamos
      {Delay 2000}
      {System.showInfo "Fin de la simulacion."}
      {Application.exit 0}
   end
end

% ozc -c contador.oz
% ozengine contador.ozf