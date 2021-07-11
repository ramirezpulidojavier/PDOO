module Civitas
  class MazoSorpresas
    
    
    def initialize(booleano = false)
      @sorpresas = []
      @cartas_especiales = []
      @barajada = false
      @usadas = 0
      @debug = booleano
      @ultima_sorpresa = nil

      if @debug
        Diario.instance.ocurre_evento("El modo debug esta activado")
      else
        Diario.instance.ocurre_evento("El modo debug esta desactivado")
      end

    end
    
    attr_reader :ultima_sorpresa
    
    
    def al_mazo(s)
      if(!@barajada)
        @sorpresas.push(s)
      end
    end
    
    def siguiente
      if ((!@barajada or @usadas == @sorpresas.length)&&!@debug)
        
          barajar
          @usadas = 0
        
      end
      util = @sorpresas.size
      @usadas = @usadas+1
      @ultima_sorpresa = @sorpresas[0]
      
      for i in(1..@sorpresas.length - 1)
        @sorpresas[i-1] = @sorpresas[i]
      end
      
      @sorpresas[@sorpresas.length-1] = @ultima_sorpresa
      return @ultima_sopresa
    end
    
    
    def inhabilitar_carta_especial (sorpresa)
      if @sorpresas.include?(sorpresa)

          @cartas_especiales << sorpresa
          Diario.instance.ocurre_evento("Se ha borrado la sorpresa #{sorpresa.to_s} y se ha pasado al mazo de cartasEspeciales")
          @sorpresas.delete(sorpresa)

      end
    end
    
    def habilitar_carta_especial (sorpresa)
      
        if @sorpresas.include?(sorpresa)
          @sorpresas.push(sorpresa)
          @cartas_especiales.delete(sorpresa)
          Diario.instance.ocurre_evento("Se ha habilitado la cartas especial #{sorpresa.to_s} y se ha puesto en sorpresas.")
        end
      
    end
    
    def barajar
      @sorpresas.shuffle!
      @barajada = true
    end
    
    def lenght_sorpresas
      return @sorpresas.length
    end
    def lenght_cartas_especiales
      return @cartas_especiales.length
    end
  end
end