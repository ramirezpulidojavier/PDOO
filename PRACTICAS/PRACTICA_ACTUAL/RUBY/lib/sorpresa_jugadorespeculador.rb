# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'jugador_especulador.rb'
require_relative 'jugador.rb'

module Civitas
  class Sorpresa_jugadorespeculador < Sorpresa
    
    def initialize(cantidad,t)
      super(t)
      @fianza = cantidad     
      
    end
    
        public_class_method :new

    def aplicar_a_jugador(actual,todos)
      if actual>=0&&actual<todos.size
        informe(actual,todos)
        jugadorespeculador = Jugador_especulador.copia(todos[actual],@fianza)
        todos[actual]=jugadorespeculador
        #todos.push(jugadorespeculador)
        #todos.pop(todos[actual])
        
      end
    end
  end
end
