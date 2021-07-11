# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'casilla.rb'
require_relative 'jugador.rb'

module Civitas
  class Casilla_juez < Casilla
    
    def initialize(nombre,num_casilla_carcel)
      super(nombre)
      @carcel = num_casilla_carcel
    end
    
     def recibe_jugador(iactual,todos)
  if (jugador_correcto(iactual,todos))
       informe(iactual,todos)
        puts "El jugador ha caido en casilla juez, se va a la carcel"
        todos[iactual].encarcelar(@carcel)
      end
    end
    
     #Override
    def to_s
      puts "Tipo Casilla Juez, casilla de la carcel: #{@carcel}"
    end
    
    
  end
end
