functor
import
   System
   Application
define
   local Contador FlujoPrueba Resultado in
      
      % 1. Definición de la función original
      fun {Contador InS}
         fun {ContarAux Flujo DictActual}
            case Flujo
            of C|Cr then
               local NuevoDict Val in
                  % CondSelect busca la llave C; si no existe, devuelve 0
                  Val = {CondSelect DictActual C 0} + 1
                  % AdjoinAt crea un nuevo registro con el valor actualizado
                  NuevoDict = {AdjoinAt DictActual C Val}
                  
                  % Retorna el nuevo diccionario y procesa recursivamente el resto
                  NuevoDict | {ContarAux Cr NuevoDict}
               end
            [] nil then nil
            end
         end
      in
         % Inicia la recursión con un registro vacío llamado 'init'
         {ContarAux InS init()}
      end

      % 2. Flujo de prueba (simulando categorías extraídas de textos)
      FlujoPrueba = [fallo acceso fallo lentitud acceso fallo]
      
      % 3. Ejecución del flujo
      Resultado = {Contador FlujoPrueba}
      
      % 4. Mostrar en consola
      {System.show Resultado}
      
      % 5. Apagado seguro de la máquina virtual para liberar RAM
      {Application.exit 0}
      
   end
end

% ozc contador.oz
% ozengine contador.oz