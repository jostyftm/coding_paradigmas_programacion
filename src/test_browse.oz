functor
import
   Browser
   Application
define
   % Definimos un registro complejo para visualizarlo
   Ticket = ticket(id:1024 estado:abierto descripcion:"Fallo en el modelo NLP" prioridad:alta)
   
   % Llamamos a la función Browse
   {Browser.browse Ticket}
   
   % Evitamos que el programa se cierre de inmediato para poder ver la ventana
   % En un entorno real, la aplicación se mantiene viva mientras la ventana esté abierta.
end