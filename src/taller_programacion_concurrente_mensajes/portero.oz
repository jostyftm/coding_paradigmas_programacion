functor
import
   System
   Application
define
   % Función genérica para crear objetos puerto
   fun {NuevoObjetoPuerto Comp Inic}
      Sin
      proc {MsgLoop S1 Estado}
         case S1 of Msg|S2 then
            {MsgLoop S2 {Comp Msg Estado}}
         [] nil then skip
         end
      end
   in
      thread {MsgLoop Sin Inic} end
      {NewPort Sin}
   end

   % Comportamiento del Portero
   fun {Comp Msg Estado}
      case Msg
      of getIn(N) then 
         {System.showInfo "   [Evento] Entraron "#N#" personas."}
         Estado + N
      [] getOut(N) then 
         {System.showInfo "   [Evento] Salieron "#N#" personas."}
         Estado - N
      [] getCount(N) then 
         N = Estado % Unificamos la variable libre con el estado actual
         Estado     % Retornamos el estado intacto
      end
   end

   local MiPortero TotalActual in
      {System.showInfo "Iniciando turno del Portero (0 personas)..."}
      
      % Instanciamos al portero con estado inicial 0
      MiPortero = {NuevoObjetoPuerto Comp 0}
      
      % Enviamos mensajes asíncronos al portero
      {Send MiPortero getIn(10)}
      {Send MiPortero getIn(5)}
      {Send MiPortero getOut(3)}
      
      % Le preguntamos cuántos hay. 
      % Pasamos una variable libre (TotalActual) dentro del mensaje.
      {Send MiPortero getCount(TotalActual)}
      
      % Sincronizamos: Esperamos a que la variable TotalActual tenga un valor
      {Wait TotalActual}
      
      {System.showInfo "-> El portero reporta que hay "#TotalActual#" personas adentro."}
      
      % Apagamos limpiamente
      {Application.exit 0}
   end
end

% ozc -c portero.oz
% ozengine portero.ozf