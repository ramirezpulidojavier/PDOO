# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_porcasahotel < Sorpresa
    
    def initialize(n,t)
      super(t)
      @valor = n
    end
    
    def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        todos[actual].modificar_saldo(@valor*(todos[actual].cantidad_casas_hoteles))
      end
    end
    
  end
end
