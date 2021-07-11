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
    
    def inicializar_mazo_sorpresas(tablero)

    ir_carcel = Sorpresa.sorpresa(tablero, TipoSorpresa::IRCARCEL)

    ir_casilla = Sorpresa.sorpresa2(tablero, TipoSorpresa::IRCASILLA, 6, "Ve a la casilla numero 6")
    ir_casilla2 = Sorpresa.sorpresa2(tablero, TipoSorpresa::IRCASILLA, 13, "Ve a la casilla numero 13")

    librarte_carcel = Sorpresa.sorpresa4(TipoSorpresa::SALIRCARCEL, @mazo)

    paga = Sorpresa.sorpresa3(TipoSorpresa::PAGARCOBRAR, -150, "Pagas 150")
    cobra = Sorpresa.sorpresa3(TipoSorpresa::PAGARCOBRAR, 150, "Recibes 150")

    paga_edificios = Sorpresa.sorpresa3(TipoSorpresa::PORCASAHOTEL, -40, "Costes por casas y hoteles")
    cobra_edificios = Sorpresa.sorpresa3(TipoSorpresa::PORCASAHOTEL, 40, "Beneficios por casas y hoteles")

    pagar_a_jugador = Sorpresa.sorpresa3(TipoSorpresa::PORJUGADOR, -20, "Pagas 20 a cada jugador")
    cobrar_de_jugador = Sorpresa.sorpresa3(TipoSorpresa::PORJUGADOR, 20, "Recibes 20 de cada jugador")


    @mazo.al_mazo(ir_carcel)
    @mazo.al_mazo(ir_casilla)
    @mazo.al_mazo(ir_casilla2)
    @mazo.al_mazo(librarte_carcel)
    @mazo.al_mazo(paga)
    @mazo.al_mazo(cobra)
    @mazo.al_mazo(paga_edificios)
    @mazo.al_mazo(cobra_edificios)
    @mazo.al_mazo(pagar_a_jugador)
    @mazo.al_mazo(cobrar_de_jugador)


  end
    
    def inicializar_tablero(mazo)

    @tablero = Tablero.new(8)


    propiedad1 = TituloPropiedad.new("Espania",400,1.2,711,1492,600)
    casilla1 = Casilla.new(propiedad1)
    @tablero.aniade_casilla(casilla1)

    propiedad2 = TituloPropiedad.new("Italia",450,1.2,752,1523,650)
    casilla2 = Casilla.new(propiedad2)
    @tablero.aniade_casilla(casilla2)

    propiedad3 = TituloPropiedad.new("Alemania",700,1.2,900,1800,900)
    casilla3 = Casilla.new(propiedad3)
    @tablero.aniade_casilla(casilla3)

    propiedad4 = TituloPropiedad.new("Belgica",500,1.2,810,1570,700)
    casilla4 = Casilla.new(propiedad4)
    @tablero.aniade_casilla(casilla4)

    propiedad5 = TituloPropiedad.new("Rusia",440,1.2,748,1510,635)
    casilla5 = Casilla.new(propiedad5)
    @tablero.aniade_casilla(casilla5)

    propiedad6 = TituloPropiedad.new("EEUU",720,1.2,930,1850,925)
    casilla6 = Casilla.new(propiedad6)
    @tablero.aniade_casilla(casilla6)

    propiedad7 = TituloPropiedad.new("Japon",325,1.2,610,1320,510)
    casilla7 = Casilla.new(propiedad7)
    @tablero.aniade_casilla(casilla7)

    propiedad8 = TituloPropiedad.new("Corea del Norte",243,1.2,523,1200,401)
    casilla8 = Casilla.new(propiedad8)
    @tablero.aniade_casilla(casilla8)

    propiedad9 = TituloPropiedad.new("Grecia",200,1.2,490,1150,350)
    casilla9 = Casilla.new(propiedad9)
    @tablero.aniade_casilla(casilla9)

    propiedad10 = TituloPropiedad.new("Madagascar",350,1.2,620,1330,520)
    casilla10 = Casilla.new(propiedad10)
    @tablero.aniade_casilla(casilla10)



    parking = Casilla.casilla("parking")
    @tablero.aniade_casilla(parking)


    propiedad11 = TituloPropiedad.new("El Caribe",750,1.2,970,1200,960)
    casilla11 = Casilla.new(propiedad11)
    @tablero.aniade_casilla(casilla11)

    impuesto = Casilla.casilla3(1000,"impuesto")
    @tablero.aniade_casilla(impuesto)

    propiedad12 = TituloPropiedad.new("Chile",450,1.2,758,1200,642)
    casilla12 = Casilla.new(propiedad12)
    @tablero.aniade_casilla(casilla12)

    sorpresa1 = Casilla.casilla5(mazo, "sorpresa1")
    @tablero.aniade_casilla(sorpresa1)

    @tablero.aniade_juez

    sorpresa2 = Casilla.casilla5(mazo, "sorpresa2")
    @tablero.aniade_casilla(sorpresa2)

    sorpresa3 = Casilla.casilla5(mazo, "sorpresa3")
    @tablero.aniade_casilla(sorpresa3)
  end
    
    def pasar_turno
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
      if (operacion == Operaciones_Juego::PASAR_TURNO)
        pasarTurno
        siguientePasoCompletado(operacion)
      else if(operacion == Operaciones_Juego::AVANZAR)
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
