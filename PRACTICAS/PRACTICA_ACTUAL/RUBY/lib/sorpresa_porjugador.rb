# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_porjugador < Sorpresa
    
    def initialize(n,t)
      @valor = n
      super(t)
    end
        public_class_method :new

      def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        uno=Sorpresa_pagarcobrar.new(@valor*(-1),"PAGARCOBRAR")
        dos=Sorpresa_pagarcobrar.new(@valor*todos.size,"PAGARCOBRAR")
        for i in 0...todos.size
          if actual!=i
            uno.aplicar_a_jugador(i,todos)
          else
            dos.aplicar_a_jugador(i,todos)
          end
        end
      end
    end
    
      
  end
end
