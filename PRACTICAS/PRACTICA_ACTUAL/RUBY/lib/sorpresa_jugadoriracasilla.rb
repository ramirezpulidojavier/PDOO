# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Sorpresa_jugadoriracasilla < Sorpresa
    
    def initialize(n,m,t)
      @tablero=n
      @valor = m
      super(t)
    end
        public_class_method :new

     def aplicar_a_jugador(actual,todos)
      puts todos[actual]
       if actual>=0&&actual<todos.size
        informe(actual,todos)
        casilla_actual=todos[actual].num_casilla_actual
        tirada=@tablero.calcular_tirada(casilla_actual,@valor)
        nposicion=@tablero.nueva_posicion(casilla_actual,tirada)
        todos[actual].mover_a_casilla(nposicion)
        @tablero.attr_get_casilla(nposicion).recibe_jugador(actual,todos)
      end
    end
    
     
  end
end
