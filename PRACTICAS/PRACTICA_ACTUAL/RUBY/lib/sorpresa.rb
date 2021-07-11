# encoding: utf-8
require_relative 'mazo_sorpresas.rb'

module Civitas
  class Sorpresa
    
    def initialize(texto)
      @texto = texto
    end
    private_class_method :new
    def aplicar_a_jugador(actual,todos)
         informe(actual,todos)
    end
    
    def informe(actual,todos)
      Diario.instance.ocurre_evento("Se esta aplicando una sorpresa al Jugador "+todos[actual].nombre)
    end
    
    def jugador_correcto(actual,todos)
      return actual>=0&&actual<todos.size
    end
    
    def to_s
      return @texto
    end
    
  end
end