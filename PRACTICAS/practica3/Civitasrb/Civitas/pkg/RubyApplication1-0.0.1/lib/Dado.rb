require "singleton"

module Civitas
  class Dado
    include Singleton
    @@SalidaCarcel = 5
    def initialize()
      @random = Random.new
      @ultimoResultado = 0
      @debug = true
    end
    
    def getInstance
      return @instance
    end
    
    def tirar
      if (@debug == false)
        @random = rand(5) + 1
        @ultimoResultado = @random
        return @random
      else
        @ultimoResultado = 1
        return 1
      end
    end
    
    def salgoDeLaCarcel
      if(tirar >= @@SalidaCarcel)
        return true
      else
        return false
      end
    end
    
    def quienEmpieza (n)
      return rand(n-1)
    end
    
    def setDebug (d)
      @debug = d
      if(@debug)
        Diario.instance.ocurre_evento("Debug activado")
          puts Diario.instance.leer_evento
      else
        Diario.instance.ocurre_evento("Debug desactivado")
          puts Diario.instance.leer_evento
      end
    end
    
    def getUltimoResultado
      return @ultimoResultado
    end
  end
end