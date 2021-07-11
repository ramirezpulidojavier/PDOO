module Civitas
  class MazoSorpresa
    def initialize (sorpresas, barajada, usadas, debug, cartasEspeciales, ultimaSorpresa)
      @sorpresas = sorpresas
      @barajada = barajada
      @usadas = usadas
      @debug = debug
      @cartasEspeciales = cartasEspeciales
      @ultimaSorpresa = ultimaSorpresa
    end
    
    private 
    def init
      @sorpresas = Array.new()
      @cartasEspeciales = Array.new()
      @barajada = false
      @usadas = 0
    end
    public
    def MazoSorpresa
      init
      @debug = false
    end
    def alMazo(s)
      if(!@barajada)
        @sorpresas.push(s)
      end
    end
    
    def siguiente
      if (!@barajada or @usadas == @sorpresas.length)
        if(!@debug)
          barajar
          @usadas = 0
          @barajada = true
        end
      end
      @usadas = @usadas+1
      @aux = @sorpresas[0]
      for i in(0..@sorpresas.length - 2)
        @sorpresas[i] = @sorpresas[i+1]
      end
      @sorpresas[@sorpresas.length-1] = @aux
      @ultimaSopresa = @aux
      return @ultimaSopresa
    end
    def inhabilitarCartaEspecial (sorpresa)
      @esta = false
      for i in (0..@sorpresas[].length-1 and !@esta)
        if (sorpresa == @sorpresas[i])
          @cartasEspeciales.push(sorpresa)
          @sorpresas.pop(i)
          @esta = true
          Diario.instance.ocurre_evento("Sorpresa deshabilitada")
          puts Diario.instance.leer_evento
        end
      end
    end
    
    def habilitarCartaEspecial (sorpresa)
      @esta = false
      for i in (0..@cartasEspeciales.length and !@esta)
        if (@cartasEspeciales[i] == sorpresa)
          @sorpresas.push(sorpresa)
          @cartasEspeciales.pop(i)
          @esta = true
          Diario.instance.ocurre_evento("Sorpresa habilitada")
          puts Diario.instance.leer_evento
        end
      end
    end
    
    def barajar
      @sorpresas.shuffle!
      @barajada = true
    end
    
    def lenghtSorpresas
      return @sorpresas.length
    end
    def lenghtCartasEspeciales
      return @cartasEspeciales.length
    end
  end
end