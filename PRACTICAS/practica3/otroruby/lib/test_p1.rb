# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative ('tablero')
require_relative ('dado')
require_relative ('casilla')
require_relative ('tipo_casilla')
require_relative ('tipo_sorpresa')
require_relative ('mazo_sorpresas')
require_relative ('sorpresa')
require_relative ('diario')
require_relative ('civitas')
require_relative ('civitas_juego')
require_relative ('estados_juego')
require_relative ('gestor_estados')
require_relative ('jugador')
require_relative ('operaciones_juego')
require_relative('titulo_propiedad')
require_relative ('vista_textual')
require_relative ('controlador')

module Civitas
  
  class Test_P1
    def self.main
      
      #hay que crear una vista textual, una instancia de CivitasJuego (dando nombres de jugadors por defecto
      #el dado en debug mode 
      #crear una instancia del controlador 
      #llamar al metodo juega de este ultimo
     
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