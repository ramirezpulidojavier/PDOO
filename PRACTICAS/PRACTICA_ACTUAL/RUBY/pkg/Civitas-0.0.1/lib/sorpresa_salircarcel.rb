# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_salircarcel < Sorpresa
    
    def initialize(n)
      @mazo = n
    end
    
    
  
    
    def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        tiene_sorpresa_evitar_carcel=false
        for j in todos
          if(j.tiene_salvoconducto)
            tiene_sorpresa_evitar_carcel=true
          end
        end
        if !tiene_sorpresa_evitar_carcel
          todos[actual].obtener_salvoconducto(self)
          salir_del_mazo
        end
      end
    end
    
      def salir_del_mazo
        @mazo.inhabilitar_carta_especial(self)
      end
      
    def usada
        @mazo.habilitar_carta_especial(self)
    end
    
    
  end
end
