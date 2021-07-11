# encoding: utf-8
require 'singleton'
require_relative 'diario.rb'

module Civitas
  class Dado
    include Singleton
    @@salida_carcel=5

    def initialize
      @ultimo_resultado=rand(1..6)               #Son necesarios los atributos random y instance en Ruby?
      @debug=false
    end

    def tirar
      if @debug
        @ultimo_resultado=1
      else
        @ultimo_resultado=rand(1..6)
      end
      puts "La tirada del dado ha sido #{@ultimo_resultado}"
      return @ultimo_resultado
    end

    def salgo_de_la_carcel
      if tirar>=@@salida_carcel
        return true
      else
        return false
      end
    end

    def quien_empieza(n)
      return rand(0...n)
    end

    def attr_set_debug(d)
      @debug=d
      if @debug
        Diario.instance.ocurre_evento("Debug esta activo")
      end
    end

    def attr_get_ultimo_resultado
      @ultimo_resultado
    end
  end
end