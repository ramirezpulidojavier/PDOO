# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_pagarcobrar < Sorpresa
    
    def initialize(n,t)
      @valor = n
      super(t)
    end
    
    def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        todos[actual].modificar_saldo(@valor)
      end
    end
    
  end
end
