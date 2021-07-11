# encoding: utf-8
require_relative 'sorpresa.rb'
require_relative 'diario.rb'

module Civitas
  class MazoSorpresas
    
    attr_reader :ultima_sorpresa
    
    def initialize(d=false)
      @debug=d
      init
      if d
        Diario.instance.ocurre_evento("Modo debug activado")
      else
        Diario.instance.ocurre_evento("Modo debug no activado")
      end
    end

    def init
      @sorpresas=[]
      @cartas_especiales=[]
      @barajada=false
      @usadas=0
      @ultima_sorpresa=nil
    end

    def al_mazo(s)
      @sorpresas.push(s) unless @barajada
    end

    def siguiente
      if !@barajada or @usadas==@sorpresas.size && !@debug
        @usadas=0
        @barajada=true
        @sorpresas.shuffle
      end
      @usadas+=1
      @sorpresas.push(@sorpresas.shift)
      @ultima_sorpresa=@sorpresas[-1]
      @ultima_sorpresa
    end

    def inhabilitar_carta_especial(sorpresa)
      if @sorpresas.include?(sorpresa)
        @sorpresas.delete(sorpresa)
        @cartas_especiales.push(sorpresa)
        Diario.instance.ocurre_evento("Se ha inhabilitado la sorpresa #{sorpresa.to_s} y se ha puesto en cartas especiales.")
      end
    end

    def habilitar_carta_especial(sorpresa)
      if @cartas_especiales.include?(sorpresa)
        @cartas_especiales.delete(sorpresa)
        @sorpresas.push(sorpresa)
        Diario.instance.ocurre_evento("Se ha habilitado la carta especial #{sorpresa.to_s} y se ha puesto en sorpresas.")
      end
    end
  end
end
