functor
import
   System
   Application
define
   local Productor Consumidor Demanda NuevaDemanda Cervezas in
      
      % 1. Productor (Bar): Sirve una cerveza cada 3 segundos
      % Solo produce si hay un elemento en el flujo de Demanda
      fun {Productor DemandaStream N Max}
         if N > Max then nil
         else
            case DemandaStream
            of _|Dr then
               {System.showInfo "-> Bar sirvio la cerveza #"#N}
               {Delay 3000} % Simula los 3 segundos
               cerveza(N) | {Productor Dr N+1 Max}
            [] nil then nil
            end
         end
      end
      
      % 2. Consumidor (Foo): Bebe una cerveza cada 12 segundos
      fun {Consumidor CervezasStream}
         case CervezasStream
         of cerveza(N)|Cr then
            {System.showInfo "   Foo empieza a beber la "#N}
            {Delay 12000} % Simula los 12 segundos
            {System.showInfo "   *** Foo termino la "#N#" ***"}
            
            % MAGIA DECLARATIVA: Al terminar, Foo genera un nuevo 'unit' 
            % Esto representa "liberar un espacio en la mesa", lo que 
            % despierta a Bar para que sirva la siguiente.
            unit | {Consumidor Cr}
         [] nil then 
            {System.showInfo "La sesion termino."}
            nil
         end
      end
      
      % -------------------------------------------------------------------
      % 3. ENSAMBLAJE DEL ALGORITMO (BUFFER LIMITADO A 5)
      % -------------------------------------------------------------------
      
      {System.showInfo "Iniciando sesion de bebida..."}
      
      % Inicializamos la mesa con exactamente 5 espacios vacíos ('unit').
      % El resto de la lista es una variable libre (NuevaDemanda) que Foo controlará.
      Demanda = unit | unit | unit | unit | unit | NuevaDemanda
      
      % Ejecutamos a Bar en un hilo. Le pedimos que sirva un máximo de 10 cervezas.
      thread Cervezas = {Productor Demanda 1 10} end
      
      % Ejecutamos a Foo en un hilo. Su consumo alimenta la variable NuevaDemanda.
      thread NuevaDemanda = {Consumidor Cervezas} end
      
      % Esperamos a que la simulación de Foo termine (esperando al hilo)
      {Wait {List.last Cervezas}}
      % Damos un tiempo extra para el último mensaje de consola
      {Delay 13000} 
      
      % Apagamos la máquina virtual limpiamente
      {Application.exit 0}
      
   end
end

% ozc -c foobar.oz
% ozengine foobar.ozf