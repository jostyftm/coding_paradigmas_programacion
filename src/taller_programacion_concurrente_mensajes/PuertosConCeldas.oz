functor
import
   System
   Application
define
   % --- IMPLEMENTACIÓN DE LA INTERFAZ ---
   fun {NuevoPuerto ?S}
      Tail = {NewCell S}
   in
      proc {$ Operacion}
         case Operacion of enviar(X) then
            NewTail
         in
            @Tail = X | NewTail
            Tail := NewTail
         end
      end
   end

   proc {Enviar P X}
      {P enviar(X)}
   end

   % --- PRUEBA EJECUTABLE ---
   local MiPuerto FlujoSalida in
      {System.showInfo "1. Probando Puertos con Celdas..."}
      
      % Creamos el puerto y extraemos su flujo
      MiPuerto = {NuevoPuerto FlujoSalida}
      
      % Enviamos mensajes usando nuestra interfaz
      {Enviar MiPuerto hola}
      {Enviar MiPuerto mundo}
      
      % Mostramos los primeros 2 elementos del flujo para confirmar
      case FlujoSalida of M1|M2|_ then
         {System.showInfo "   -> Flujo capturado: "#M1#" "#M2}
      end
      
      {Delay 1000}
      {Application.exit 0}
   end
end

% ozc -c PuertosConCeldas.oz
% ozengine PuertosConCeldas.ozf