# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'casilla.rb'
require_relative 'mazo_sorpresas.rb'
require_relative 'sorpresa.rb'


module Civitas
  class Casilla_sorpresa < Casilla
    
    def initialize(n, mazo)
      super(n);
      @mazo = mazo
    end
    
    #Override
    def recibe_jugador(iactual,todos)
       if (jugador_correcto(iactual,todos))
        @sorpresa=@mazo.siguiente
        informe(iactual,todos)
        puts @sorpresa
        @sorpresa.aplicar_a_jugador(iactual,todos)
      end
    end
    
      #Override
    def to_s

      puts "Casilla tipo sorpresa, sorpresa: #{@sorpresa}" 
    end
    
  end
end