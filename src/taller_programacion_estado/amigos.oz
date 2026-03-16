functor
import
   System
   Application
define
   local PagoDeuda Resultado1 Resultado2 in

      fun {PagoDeuda Amistades Deudas}
         local N Visited Graph DFS CheckAll DeudasArr in
            % El tamaño de la lista de deudas nos da el total de personas
            N = {Length Deudas}
            
            % Arreglo de estado: Visitados inicializados en false
            Visited = {NewArray 1 N false}
            
            % Grafo (Arreglo de listas): Amigos de cada persona
            Graph = {NewArray 1 N nil}

            % Llenar el grafo de amistades de forma bidireccional
            {List.forAll Amistades
               proc {$ Edge}
                  case Edge of I#J then
                     {Array.put Graph I J|{Array.get Graph I}}
                     {Array.put Graph J I|{Array.get Graph J}}
                  else skip end
               end
            }

            % Convertimos la lista de deudas a un Arreglo para acceso rapido O(1)
            DeudasArr = {NewArray 1 N 0}
            {List.forAllInd Deudas
               proc {$ I Val} {Array.put DeudasArr I Val} end
            }

            % --- Algoritmo DFS (Busqueda en Profundidad) ---
            % Suma recursivamente las deudas de todos los amigos conectados
            fun {DFS Node}
               if {Array.get Visited Node} then 0
               else
                  local SumFriends in
                     % Marcamos el nodo como visitado
                     {Array.put Visited Node true}
                     
                     % Funcion recursiva para recorrer la lista de amigos
                     fun {SumFriends Friends}
                        case Friends of F|Fr then
                           {DFS F} + {SumFriends Fr}
                        [] nil then 0
                        end
                     end
                     
                     % Retorna: Deuda actual + Suma de deudas de sus amigos
                     {Array.get DeudasArr Node} + {SumFriends {Array.get Graph Node}}
                  end
               end
            end

            % --- Verificacion de Componentes ---
            % Revisa que la suma de todos los subgrupos (componentes) sea exactamente 0
            fun {CheckAll I}
               if I > N then true
               else
                  % Si la persona no ha sido visitada, es un nuevo grupo de amigos
                  if {Array.get Visited I} == false then
                     % Si la suma de las deudas del grupo NO es 0, es imposible pagar
                     if {DFS I} \= 0 then false
                     else {CheckAll I+1} end
                  else
                     {CheckAll I+1}
                  end
               end
            end

            % Iniciamos la verificacion desde la persona 1
            {CheckAll 1}
         end
      end

      % --- Casos de Prueba ---
      % Nota: Usamos ~ para los negativos nativos de Oz
      
      % Ejemplo 1 (Asumiendo correcciones logicas para que sume 0 por grupo)
      Resultado1 = {PagoDeuda [1#2 2#3 4#5] [100 ~75 ~25 42 ~42]}
      
      % Ejemplo 2 (Tomado del PDF)
      Resultado2 = {PagoDeuda [1#2 2#4] [15 20 ~10 ~25]}

      {System.showInfo "Resultado Ejemplo 1 (Deberia ser true):"}
      {System.show Resultado1}
      
      {System.showInfo "Resultado Ejemplo 2 (Deberia ser false):"}
      {System.show Resultado2}

      % Apagar contenedor
      {Application.exit 0}
   end
end

% ozc -c amigos.oz
% ozengine amigos.ozf