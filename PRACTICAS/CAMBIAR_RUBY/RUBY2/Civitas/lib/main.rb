require_relative 'test_p1.rb'
require_relative 'Casilla.rb'
require_relative 'TipoSorpresa.rb'
require_relative 'titulo_propiedad.rb'
require_relative 'TipoCasilla.rb'
require_relative 'Tablero.rb'
require_relative 'Dado.rb'
require_relative 'estados_juego.rb'
require_relative 'operaciones_juego.rb'
require_relative 'Sorpresa.rb'
require_relative 'MazoSorpresa.rb'
require_relative 'gestor_estados.rb'
require_relative 'civitas_juego.rb'
require_relative 'Jugador.rb'
require_relative 'controlador.rb'
require_relative 'salidas_carcel.rb'
require_relative 'operacion_inmobiliaria.rb'
require_relative 'respuestas.rb'
require_relative 'estados_juego.rb'
require_relative 'vista_textual.rb'

module Civitas
  
  class Test_P1
    def self.main
              
      vista = Vista_textual.new
      
      nombres = Array.new
      
      nombres << "Manu"
      nombres << "Javi"
      nombres << "Angel"
      
      ins = CivitasJuego.new(nombres)
      
      Dado.instance.set_debug(true)
      
      controlador = Controlador.new(ins, vista)
      controlador.juega
      
    end
   main  
  end
  
 
end