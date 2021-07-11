# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'casilla.rb'
require_relative 'jugador.rb'

module Civitas
  class Casilla_impuesto < Casilla
    
    attr_reader :importe
    
    def initialize(nombre,importe)
      super(nombre)
      @importe = importe
    end

     def recibe_jugador(iactual,todos)
      if (jugador_correcto(iactual,todos))
          informe(iactual,todos)
        todos[iactual].paga_impuesto(@importe)
      end
    end
    
     #Override
     def to_s
      puts "Tipo Casilla Impuesto, importe: #{@importe}"
    end

  end
end