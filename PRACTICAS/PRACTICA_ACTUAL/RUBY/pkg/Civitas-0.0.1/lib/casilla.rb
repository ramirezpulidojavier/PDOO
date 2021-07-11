# encoding: utf-8

require_relative 'jugador.rb'



module Civitas
  class Casilla
    
    
    attr_reader   :nombre
    
    def initialize(nombre)
      @nombre=nombre 
    end
    

    def informe(iactual,todos)
      Diario.instance.ocurre_evento("El jugador "+todos[iactual].nombre)
    end
    
    def jugador_correcto(iactual,todos)
      result=false
      if (iactual>=0)&&(iactual<todos.size)
        result =true
      end
      return result
    end
    
   def recibe_jugador(iactual,todos)
        informe(iactual,todos)  
    end

   
    def to_s
        puts  "Casilla tipo descanso, nombre: "+@nombre
      
    end
        
    
  end
end