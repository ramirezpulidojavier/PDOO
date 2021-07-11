# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_ircarcel < Sorpresa
    
    
    def initialize(n)
      @texto="VAS A LA CARCEL"
      @tablero = n
    end    
    public_class_method :new

    
    
    def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        todos[actual].encarcelar(@tablero.attr_get_carcel)
      end
    end
    
    
  end
end
