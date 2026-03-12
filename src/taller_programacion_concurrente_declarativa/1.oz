functor
import
   Browser
define
   local A B C D in
      % Lanzamos los hilos concurrentes
      thread D = C + 1 end
      thread C = B + 1 end
      thread A = 1 end
      thread B = A + 1 end
      
      % Visualizamos el resultado final
      {Browser.browse D}
   end
end

% ozc 1.oz
% ozengine 1.oz