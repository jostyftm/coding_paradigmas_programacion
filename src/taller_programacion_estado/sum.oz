functor
import
   System
   Application
define
   local SumAB in
      fun {SumAB A B}
         local Suma Actual Loop in
            Suma = {NewCell 0}
            Actual = {NewCell A}
            
            proc {Loop}
               if @Actual =< B then
                  Suma := @Suma + @Actual
                  Actual := @Actual + 1
                  {Loop}
               else skip end
            end
            
            {Loop}
            @Suma
         end
      end

      {System.show {SumAB 1 10}}
      {Application.exit 0}
   end
end


% ozc -c sum.oz
% ozengine sum.ozf