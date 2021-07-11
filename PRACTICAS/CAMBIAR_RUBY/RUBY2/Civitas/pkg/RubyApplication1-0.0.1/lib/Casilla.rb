module Civitas
  class Casilla
    attr_accessor :nombre, :tipo, :importe, :numCasillaCarcel, :titulo, :mazo
    def initialize (n, tipo, importe, numCasillaCarcel, titulo, mazo)
      init()
      @nombre = n
      @tipo = tipo
      @importe = importe
      @numCasillaCarcel = numCasillaCarcel
      @titulo = titulo
      @mazo = mazo
      @sorpresa
    end
    
    def init
      @nombre = "nombre"
      @importe = 0
      @carcel = 0
    end
    
    def informe(actual, todos)
      Diario.instance.ocurre_evento(todos[actual].nombre + " ha caido en la casilla: #{nombre}")
      puts Diario.instance.leer_evento
      puts toString
    end
    
    def toString
      return "nombre: #{nombre} - importe: #{importe} - carcel: #{numCasillaCarcel}"
    end
    
    def jugadorCorrecto(actual, todos)
      return actual < todos.lenght
    end
    
    def recibeJugador_impuesto(actual, todos)
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        todos[actual].paga(@importe)
      end
    end
    
    def recibeJugador_juez(actual, todos)
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        todos[actual].encarcelar(@numCasillaCarcel)
      end
    end
    
    def recibeJugador(actual, todos)
      case @tipo
      when TipoCasilla::CALLE
        recibeJugador_calle(actual,todos)
      when TipoCasilla::IMPUESTO
        recibeJugador_impuesto(actual,todos)
      when TipoCasilla::JUEZ
        recibeJugador_juez(actual, todos)
      when TipoCasilla::SORPRESA
        recibeJugador_sorpresa(actual,todos)
      else
        informe(actual,todos)
      end
    end
    
    def recibeJugador_calle(actual, todos)
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        jugador = todos[actual]
        if (!@titulo.tienePropietario)
          jugador.puedeComprarCasilla
        else
          @titulo.tramitarAlquiler(jugador)
        end
      end
    end
    
    def recibeJugador_sorpresa(actual, todos)
      if (jugadorCorrecto(actual, todos))
        sorpresa = @mazo.siguiente
        informe(actual,todos)
        sorpresa.aplicarAJugador(actual, todos)
      end
    end
    
    private :init
  end
end
