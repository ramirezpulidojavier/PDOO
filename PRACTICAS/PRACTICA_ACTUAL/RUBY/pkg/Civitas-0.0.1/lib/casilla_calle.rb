# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'casilla.rb'
require_relative 'titulo_propiedad.rb'
require_relative 'jugador.rb'

module Civitas
  class Casilla_calle < Casilla
  
      attr_reader :titulo_propiedad

     def initialize(titulo)
        super(titulo.nombre)
        @titulo_propiedad = titulo
      end
      
      #Override
      def recibe_jugador(iactual,todos)
       if (jugador_correcto(iactual,todos))
          informe(iactual,todos)
         jugador = todos[iactual]
         if !@titulo_propiedad.tiene_propietario
           jugador.puede_comprar_casilla
         else
           @titulo_propiedad.tramitar_alquiler(jugador)
         end
       end
     end
     
    #Override
    def to_s

      puts "Tipo Casilla Calle,  Titulo Propiedad:  "+@titulo_propiedad.to_s  
    end

   

  
  end
end