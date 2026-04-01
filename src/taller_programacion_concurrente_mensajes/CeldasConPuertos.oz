functor
import
   System
   Application
define
   % --- IMPLEMENTACIÓN DE LA INTERFAZ ---
   fun {NuevaCelda Init}
      P S
   in
      {NewPort S P}
      thread
         proc {Loop Stream State}
            case Stream
            of acceder(X)|T then
               X = State
               {Loop T State}
            [] asignar(NewState)|T then
               {Loop T NewState}
            [] nil then skip
            end
         end
      in
         {Loop S Init}
      end
      
      proc {$ Msg} {Send P Msg} end
   end

   proc {Acceder X C} {C acceder(X)} end
   proc {Asignar X C} {C asignar(X)} end

   % --- PRUEBA EJECUTABLE ---
   local MiCelda Valor1 Valor2 in
      {System.showInfo "2. Probando Celdas con Puertos..."}
      
      % Creamos la celda con valor inicial 100
      MiCelda = {NuevaCelda 100}
      
      % Accedemos al valor inicial
      {Acceder Valor1 MiCelda}
      {Wait Valor1}
      {System.showInfo "   -> Valor inicial: "#Valor1}
      
      % Asignamos un nuevo valor
      {Asignar 500 MiCelda}
      
      % Accedemos al nuevo valor
      {Acceder Valor2 MiCelda}
      {Wait Valor2}
      {System.showInfo "   -> Valor despues de asignar: "#Valor2}
      
      {Delay 1000}
      {Application.exit 0}
   end
end

% ozc -c CeldasConPuertos.oz
% ozengine CeldasConPuertos.ozf