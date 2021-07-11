module Civitas
  class CivitasJuego
    attr_accessor :jugadores, :gestosEstados, :estado, :indiceJugadorActual, :mazo, :tablero
    def initialize (nombres)
      @jugadores = Array.new()
      for i in (0..(nombres.length-1))
        jugador = Jugador.new(nombres[i])
        @jugadores.push(jugador)
      end
      @gestorEstados = Gestor_estados.new
      @estado = @gestorEstados.estado_inicial
      @indiceJugadorActual = Dado.instance.quienEmpieza(nombres.length)
      @mazo = MazoSorpresa.new(sorpresas = Array.new, false, 0, true, cartasEspeciales = Array.new, ultimaSorpresa = Sorpresa.newIRCASILLA(0, "IR CASILLA SALIDA", @tablero))
      @tablero = Tablero.new(10, casillas = Array.new, 0, true)
      inicializarTablero(@mazo)
      inicializarMazoSorpresas(@tablero)
    end
    
    def avanzaJugador
      jugadorActual = @jugadores[@indiceJugadorActual]
      posicionActual = jugadorActual.numCasillaActual
      tirada = Dado.instance.tirar
      posicionNueva = @tablero.nuevaPosicion(posicionActual, tirada)
      casilla = @tablero.getCasilla(posicionNueva)
      contabilizarPasosPorSalida(jugadorActual)
      jugadorActual.moverACasilla(posicionNueva)
      casilla.recibeJugador(@indiceJugadorActual, @jugadores)
      contabilizarPasosPorSalida(jugadorActual)
    end
    
    def cancelarHipoteca(ip)
      @jugadores[@indiceJugadorActual].cancelarHipoteca(ip)
    end
    
    def comprar
      result = false
      jugadorActual = @jugadores[@indiceJugadorActual]
      numCasillaActual = jugadorActual.numCasillaActual
      casilla = @tablero.getCasilla(numCasillaActual)
      titulo = casilla.titulo
      result = jugadorActual.comprar(titulo)
      return result
    end
    
    def construirCasa(ip)
      @jugadores[@indiceJugadorActual].construirCasa(ip)
    end
    
    def construirHotel (ip)
      @jugadores[@indiceJugadorActual].construirHotel(ip)
    end
    
    def contabilizarPasosPorSalida (jugador)
      while (@tablero.getPorSalida > 0)
        jugador.pasaPorSalida
      end
    end
    
    def finalDelJuego
      for i in (0..@jugadores.length-1)
        if(@jugadores[i].enBancarrota)
          return true
        end
      end
      return false
    end
    
    def getJugadorActual
      return @jugadores[@indiceJugadorActual]
    end
    
    def getCasillaActual
      return @tablero.getCasilla(getJugadorActual.numCasillaActual)
    end
    
    def hipotecar (ip)
      @jugadores[@indiceJugadorActual].hipotecar(ip)
    end
    
    def infoJugadorTexto
      return @jugadores[@indiceJugadorActual].toString
    end
    
    def inicializarMazoSorpresas (tablero)
      for i in (0..2)   # 3 sorpresas IRCARCEL
        carta = Sorpresa.newIRCARCEL(tablero)
        @mazo.alMazo(carta)
      end
      
      for j in (0..1)   # 2 sorpresas SALIRCARCEL
        @carta = Sorpresa.newSALIRCARCEL(tablero)
        @mazo.alMazo(@carta)
      end
      
      for k in (0..1)   # 2 sorpresas PORCASAHOTEL
        carta = Sorpresa.newPORCASAHOTEL(150, "Por casa/hotel")
        @mazo.alMazo(carta)
      end
      
      for x in (0..9)   # 10 sorpresas PAGARCOBRAR
        carta = Sorpresa.newPAGARCOBRAR(300, "Pagar/cobrar")
        @mazo.alMazo(carta)
      end
      
      for y in (0..4)   # 5 sorpresas IRCASILLA
        valor = rand(39)
        carta = Sorpresa.newIRCASILLA(valor, "ve a la casilla #{valor}", tablero)
        @mazo.alMazo(carta)
      end
      
      for z in (0..2)   # 3 sorpresas PORJUGADOR
        carta = Sorpresa.newPORJUGADOR(200, "Por jugador")
        @mazo.alMazo(carta)
      end
      
      @mazo.barajar
    end
    
    def inicializarTablero(mazo)
      @tablero = Tablero.new(20, casillas = Array.new, 0, true)
      @tablero.borrar_casilla(0)
      for i in (0..39)
        if (i == 0)
          casilla = Casilla.new("Salida", TipoCasilla::DESCANSO, 1000, 10, nil, mazo)
        else if (i == 10)
            casilla = Casilla.new("Carcel", TipoCasilla::DESCANSO, 0, 10, nil, mazo)
        else if (i == 30)
            casilla = Casilla.new("Juez", TipoCasilla::JUEZ, 0, 10, nil, mazo)
        else if (i % 10 == 0)
              casilla = Casilla.new("Descanso", TipoCasilla::DESCANSO, 0, 10, nil, mazo)
        else if (i % 5 == 0)
            casilla = Casilla.new("Sorpresa", TipoCasilla::SORPRESA, 0, 10, nil, mazo)
        else
              casilla = Casilla.new("Calle", TipoSorpresa::IRCASILLA, 0, 10, titulo = TituloPropiedad.new("casa", 500*(i/10+1), 500*(i/10+1), 500*(i/10+1), 500*(i/10+1), 500*(i/10+1)), mazo)
        end
        end
        end
        end
        end
        @tablero.aniadeCasilla(casilla)
      end
    end
    
    def pasarTurno
      @indiceJugadorActual += 1
      if (@indiceJugadorActual == @jugadores.length)
        @indiceJugadorActual = 0
      end
    end
    
    def ranking
      return @jugadores.sort { |x,y|  x.saldo <=> y.saldo}
    end
    
    def salirCarcelPagando
      @jugadores[@indiceJugadorActual].salirCarcelPagando
    end
    
    def salirCarcelTirando
      @jugadores[@indiceJugadorActual].salirCarcelTirando
    end
    
    def siguientePaso
      jugadorActual = @jugadores[@indiceJugadorActual]
      operacion = @gestorEstados.operaciones_permitidas(jugadorActual, @estado)
      if (operacion == OperacionesJuego::PASAR_TURNO)
        pasarTurno
        siguientePasoCompletado(operacion)
      else if(operacion == OperacionesJuego::AVANZAR)
          avanzaJugador
          if(@tablero.getCasilla(jugadorActual.numCasillaActual).titulo.tienePropietario)
            puts "La casilla tiene propietario: #{@tablero.getCasilla(jugadorActual.numCasillaActual).titulo.propietario.nombre}"
            if (@tablero.getCasilla(jugadorActual.numCasillaActual).titulo.propietarioEncarcelado)
              puts "#{@tablero.getCasilla(jugadorActual.numCasillaActual).titulo.propietario.nombre} esta encarcelado, no pagas."
            else
              alquiler = @tablero.getCasilla(jugadorActual.numCasillaActual).titulo.getPrecioAlquiler
              puts "Pagas #{alquiler} a #{@tablero.getCasilla(jugadorActual.numCasillaActual).titulo.propietario.nombre}"
              jugadorActual.pagaAlquiler(alquiler)
              @tablero.getCasilla(jugadorActual.numCasillaActual).titulo.propietario.recibe(alquiler)
            end
          end
          siguientePasoCompletado(operacion)
        end
      end
      return operacion
    end
    
    def siguientePasoCompletado (operacion)
      @estado = @gestorEstados.siguiente_estado(@jugadores[@indiceJugadorActual], @estado, operacion)
    end
    
    def vender (ip)
      @jugadores[@indiceJugadorActual].vender (ip)
    end
    
    private :avanzaJugador, :contabilizarPasosPorSalida, :inicializarMazoSorpresas, :inicializarTablero, :pasarTurno
  end
end
