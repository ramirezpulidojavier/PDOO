
require './jugador'
require './casilla'
module Civitas
  class CivitasJuego
    
    def initialize(nombres)

      @gestor_estados = Gestor_estados.new
      @jugadores = Array.new
      @tablero = Tablero.new(8)
      @estado = @gestor_estados.estado_inicial
      @indice_jugador_actual = Dado.instance.quien_empieza(@jugadores.length)
      @mazo = MazoSorpresas.new

      for i in (0..nombres.size-1)

        nuevo_jugador = Jugador.jugador1(nombres.at(i))
        @jugadores << nuevo_jugador

      end


      inicializar_mazo_sorpresas(@tablero)
      inicializar_tablero(@mazo)
  
    end

    attr_accessor :jugadores, :gestos_estados, :estado, :indice_jugador_actual, :mazo, :tablero
    
    private
    
    def avanza_jugador
        jugador_actual = @jugadores[@indice_jugador_actual]

        posicion_actual = @jugadores[@indice_jugador_actual].num_casilla_actual

        tirada = Dado.instance.tirar


        posicion_nueva = @tablero.nueva_posicion(posicion_actual, tirada)

        casilla = @tablero.get_casilla(posicion_nueva)

        contabilizar_pasos_por_salida(jugador_actual)
        jugador_actual.mover_a_casilla(posicion_nueva)

        casilla.recibe_jugador(@indice_jugador_actual, @jugadores)

        contabilizar_pasos_por_salida(jugador_actual)
    end
    
    
    public
    def cancelar_hipoteca(ip)
      @jugadores[@indice_jugador_actual].cancelar_hipoteca(ip)
    end
    
    def comprar
      jugador_actual = @jugadores[@indice_jugador_actual]
      num_casilla_actual = jugador_actual.num_casilla_actual
      casilla = @tablero.get_casilla(num_casilla_actual)
      titulo = casilla.titulo_propiedad
      result = jugador_actual.comprar(titulo)
      return result
    end
    
    def construir_imperio()
        @jugadores[@indice_jugador_actual].construir_imperio()
        
    end
    def construir_casa(ip)
      @jugadores[@indice_jugador_actual].construir_casa(ip)
    end
    
    def construir_hotel (ip)
      @jugadores[@indice_jugador_actual].construir_hotel(ip)
    end
    
    private
    
    def contabilizar_pasos_por_salida (jugador)
      while (@tablero.get_por_salida > 0)
        jugador.pasa_por_salida
      end
    end
    
    public
    
    def final_del_juego
      for i in (0..@jugadores.length-1)
        if(@jugadores.at(i).en_bancarrota)
          return true
        end
      end
      return false
    end
    
    def get_casilla_actual
      return @tablero.get_casilla(get_jugador_actual.num_casilla_actual)
    end
    
    def get_jugador_actual
      return @jugadores[@indice_jugador_actual]
    end
    
    
    
    def hipotecar (ip)
      @jugadores[@indice_jugador_actual].hipotecar(ip)
    end
    
    def info_jugador_texto
      return @jugadores[@indice_jugador_actual].to_s
    end
    
    private
    
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
      
      sorpresa1 = Casilla.casilla5(mazo, "SORPRESA 1")
      @tablero.aniade_casilla(sorpresa1)

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

      sorpresa2 = Casilla.casilla5(mazo, "SORPRESA 2")
      @tablero.aniade_casilla(sorpresa2)
      
      propiedad9 = TituloPropiedad.new("Grecia",200,1.2,490,1150,350)
      casilla9 = Casilla.new(propiedad9)
      @tablero.aniade_casilla(casilla9)

      propiedad10 = TituloPropiedad.new("Madagascar",350,1.2,620,1330,520)
      casilla10 = Casilla.new(propiedad10)
      @tablero.aniade_casilla(casilla10)
      
      parking = Casilla.casilla("parking")
      @tablero.aniade_casilla(parking)
      
      @tablero.aniade_juez

      propiedad11 = TituloPropiedad.new("El Caribe",750,1.2,970,1200,960)
      casilla11 = Casilla.new(propiedad11)
      @tablero.aniade_casilla(casilla11)

      sorpresa3 = Casilla.casilla5(mazo, "SOPRESA 3")
      @tablero.aniade_casilla(sorpresa3)
      
      impuesto = Casilla.casilla3(1000,"impuesto")
      @tablero.aniade_casilla(impuesto)

      propiedad12 = TituloPropiedad.new("Chile",450,1.2,758,1200,642)
      casilla12 = Casilla.new(propiedad12)
      @tablero.aniade_casilla(casilla12)

    end
    
    def pasar_turno
      @indice_jugador_actual = (@indice_jugador_actual +1)%@jugadores.size
    end
    public
    def ranking
      return @jugadores.sort { |x,y|  x.saldo <=> y.saldo}
    end
    
    def salir_carcel_pagando
      @jugadores[@indice_jugador_actual].salir_carcel_pagando
    end
    
    def salir_carcel_tirando
      @jugadores[@indice_jugador_actual].salir_carcel_tirando
    end
    public
    
    def siguiente_paso_completado (operacion)
      @estado = @gestor_estados.siguiente_estado(@jugadores[@indice_jugador_actual], @estado, operacion)
    end
    
    def siguiente_paso

        jugador_actual= @jugadores.at(@indice_jugador_actual)
        operacion= @gestor_estados.operaciones_permitidas(jugador_actual, @estado)
        if operacion==Operaciones_Juego::PASAR_TURNO

            pasar_turno
            siguiente_paso_completado(operacion)

        elsif operacion==Operaciones_Juego::AVANZAR

            avanza_jugador
            siguiente_paso_completado(operacion)

        end

        return operacion
  end
    
    
    
    def vender (ip)
      @jugadores[@indice_jugador_actual].vender(ip)
    end
    
    def get_casilla_actual
        return @tablero.get_casilla(@jugadores.at(@indice_jugador_actual).num_casilla_actual)
    end
    
    def get_jugador_actual
        return @jugadores.at(@indice_jugador_actual);
    end
    
  end
end
