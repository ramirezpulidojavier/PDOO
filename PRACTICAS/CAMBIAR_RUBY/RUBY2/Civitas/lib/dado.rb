require "singleton"

module Civitas
  class Dado
    include Singleton
    @@SalidaCarcel = 5
    def initialize()
      @random = Random.new
      @ultimo_resultado = 0
      @debug = true
    end
    
    def get_instance
      return @instance
    end
    
    def tirar
      if (@debug == false)
        @random = rand(5) + 1
        @ultimo_resultado = @random
        return @random
      else
        @ultimo_resultado = 1
        return 1
      end
    end
    
    def salgo_de_la_carcel
      if(tirar >= @@SalidaCarcel)
        return true
      else
        return false
      end
    end
    
    def quien_empieza (n)
      return rand(n-1)
    end
    
    def set_debug (d)
      @debug = d
      if(@debug)
        Diario.instance.ocurre_evento("Debug activado")
          puts Diario.instance.leer_evento
      else
        Diario.instance.ocurre_evento("Debug desactivado")
          puts Diario.instance.leer_evento
      end
    end
    
    def get_ultimo_resultado
      return @ultimo_resultado
    end
  end
end