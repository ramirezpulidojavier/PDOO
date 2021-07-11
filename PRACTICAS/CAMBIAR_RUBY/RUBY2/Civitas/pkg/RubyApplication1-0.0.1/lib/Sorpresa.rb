require_relative 'diario.rb'
module Civitas
  class Sorpresa
    attr_accessor :parametros, :tipo, :tablero, :valor, :texto
    def initialize (tipo, texto, valor, tablero, mazo)
      @tipo = tipo
      @texto = texto
      @valor = valor
      @tablero = tablero
      @mazo = mazo
    end
    
    def init
      @texto = ""
      @valor = -1
      @tablero = nil
      @mazo = nil
    end
    
    def self.newPAGARCOBRAR (valor, texto)
      new(TipoSorpresa::PAGARCOBRAR, texto, valor, _tablero = @tablero, _mazo = @mazo)
    end
    
    def self.newIRCASILLA (valor, texto, tablero)
      new(TipoSorpresa::IRCASILLA, texto, valor, tablero, _mazo = @mazo)
    end
    
    def self.newPORCASAHOTEL (valor, texto)
      new(TipoSorpresa::PORCASAHOTEL, texto, valor, nil, nil)
    end
    
    def self.newPORJUGADOR (valor, texto)
      new(TipoSorpresa::PORJUGADOR, texto, valor, nil, nil)
    end
    
    def self.newIRCARCEL (tablero)
      new(TipoSorpresa::IRCARCEL, "Ir carcel", -1, tablero, nil)
    end
    
    def self.newSALIRCARCEL (tablero)
      new(TipoSorpresa::SALIRCARCEL, "Salir carcel", -1, tablero, nil)
    end
    
    def jugadorCorrecto(actual, todos)
      return actual < todos.length
    end

    def informe(actual, todos)
      if(jugagorCorrecto(actual,todos))
        Diario.instance.ocurre_evento("Sorpresa aplicada a: " + todos[actual].getNombre)
        puts Diario.instance.leer_evento
      end
    end
    
    def aplicarAJugador(actual, todos)
      case @tipo
      when IRCARCEL
        aplicarAJugador_irCarcel(actual, todos)
      when IRCASILLA
        aplicarAJugador_irACasilla(actual, todos)
      when PAGARCOBRAR
        aplicarAJugador_pagarCobrar(actual, todos)
      when PORCASAHOTEL
        aplicarAJugador_porCasaHotel(actual, todos)
      when PORJUGADOR
        aplicarAJugador_porJugador(actual, todos)
      when SALIRCARCEL
        aplicaAJugador_salirCarcel(actual, todos)
      end
    end
    
    def aplicarAJugador_irCarcel(actual, todos)
      if (jugadorCorrecto(actual,todos))
        informe(actual, todos)
        todos[actual].encarcelar
      end
    end
    
    def aplicarAJugador_irACasilla(actual, todos)
      if (jugadorCorrecto(actual,todos))
        informe(actual, todos)
        @casilla_actual = todos[actual].getCasillaActual
        @tirada = @tablero.calculaTirada(@casilla_actual, @valor)
        todos[actual].moverACasilla(@tablero.nuevaCasilla(@casilla_actual, @tirada))
        @tablero.getCasilla(todos[actual].getNumCasillaActual).recibeJugador(actual, todos)
      end
    end
    
    def aplicarAJugador_pagarCobrar(actual, todos)
      if(jugadorCorrecto(actual,todos))
        informe(actual, todos)
        todos[actual].modificarSaldo(@valor)
      end
    end
    
    def aplicarAJugador_porCasaHotel(actual, todos)
      if(jugadorCorrecto(actual, todos))
        informe(actual, todos)
        todos[actual].modificarSaldo(@valor*todos[actual].cantidadCasasHoteles)
      end
    end
    
    def aplicarAJugador_porJugador(actual, todos)
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        pagar = Sorpresa.new(TipoSorpresa::PAGARCOBRAR,"pagar", -@valor, @tablero, nil)
        cobrar = Sorpresa.new(TipoSorpresa::PAGARCOBRAR,"pagar", @valor * (todos.length-1), @tablero, nil)
        for i in(0..todos.length-1)
          if (i == actual)
            todos[i].modificarSaldo(cobrar.valor)
          else
            todos[i].modificarSaldo(pagar.valor)
          end
        end
      end
    end
    
    def aplicarAJugador_salirCarcel(actual, todos)
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        @la_tienen = false
        for i in (0..todos.length-1)
          if (todos[i].tieneSalvoconducto)
            @la_tienen = true
          end
          if (!@la_tienen)
            todos[actual].obtenerSalvaconducto(this)
            salirDelMazo
          end
        end
      end
    end
    
    def salirDelMazo
      if (@tipo == TipoSorpresa::SALIRCARCEL)
        @mazo.inhabilitarCartaEspecial(this)
      end
    end
    
    def usada
      if (@tipo == TipoSorpresa::SALIRCARCEL)
        @mazo.habilitarCartaEspecial(this)
      end
    end
    
    def toString
      return @texto
    end
  end
end