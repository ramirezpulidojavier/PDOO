require_relative 'civitas_juego.rb'
require_relative 'vista_textual.rb'
require_relative 'controlador.rb'
require_relative 'dado.rb'
require_relative 'jugador.rb'
require_relative 'estados_juego.rb'

module Civitas
  class TestP3
    def initialize

    end

    def self.main

      vistatextual = Vista_textual.new
      jugadores = Array.new

      puts "Cuantos jugadores van a jugar? "
      respuesta=gets.to_i

      for i in (0..respuesta-1)
        puts "\nJugador #{i+1}: "
        jugadores.push(gets.chomp)
      end

      partida = Civitas_juego.new(jugadores)

      Dado.instance.attr_set_debug(false)

      controlador = Controlador.new(partida,vistatextual)
      controlador.juega

    end

    end

  TestP3.main
end