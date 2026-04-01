functor
import
   System
   Application
define
   % 1. Funcion generica para crear objetos puerto
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

   % 2. Actualizador de estado (Diccionario inmutable)
   fun {UpdateCount Char State}
      case State
      of (C#N)|T then
         if C == Char then (C#(N+1))|T
         else (C#N)|{UpdateCount Char T} end
      [] nil then [Char#1]
      end
   end

   % 3. EL CONTADOR2: Interaccion de dos puertos
   fun {Counter Output}
      local OutPort in
         % Creamos el puerto secundario. Su flujo es 'Output'
         OutPort = {NewPort Output}
         
         % Comportamiento del objeto principal
         fun {Comp Msg Estado}
            local NuevoEstado = {UpdateCount Msg Estado} in
               % Interaccion: El puerto principal le envia un mensaje al secundario
               {Send OutPort NuevoEstado}
               NuevoEstado
            end
         end
      in
         % Retornamos el objeto puerto principal instanciado
         {NuevoObjetoPuerto Comp nil}
      end
   end

   % --- PRUEBA EJECUTABLE ---
   local MiServidor FlujoSalida in
      {System.showInfo "3. Probando Contador2 (Interaccion de Puertos)..."}
      
      % Instanciamos el servidor y extraemos su flujo de salida
      MiServidor = {Counter FlujoSalida}
      
      % Creamos un hilo consumidor NO reactivo que lee el flujo de salida
      thread
         proc {LeerFlujo S}
            case S of Estado|T then
               {System.showInfo "   [Output Stream] Estado actualizado:"}
               {System.show Estado}
               {LeerFlujo T}
            [] nil then skip
            end
         end
      in
         {LeerFlujo FlujoSalida}
      end
      
      % Simulamos clientes interactuando con el servidor
      {System.showInfo "-> Clientes enviando letras..."}
      {Send MiServidor a}
      {Delay 500}
      {Send MiServidor b}
      {Delay 500}
      {Send MiServidor a}
      
      {Delay 1000}
      {Application.exit 0}
   end
end

% ozc -c contador2.oz
% ozengine contador2.ozf