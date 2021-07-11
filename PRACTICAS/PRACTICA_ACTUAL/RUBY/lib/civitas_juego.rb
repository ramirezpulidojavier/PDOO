# encoding: utf-8
require_relative 'titulo_propiedad.rb'
require_relative 'casilla.rb'
require_relative 'jugador.rb'
require_relative 'sorpresa.rb'
require_relative 'gestor_estados.rb'
require_relative 'operaciones_juego.rb'
require_relative 'mazo_sorpresas.rb'
require_relative 'tablero.rb'
require_relative 'estados_juego.rb'
require_relative 'casilla_calle.rb'
require_relative 'casilla_sorpresa.rb'
require_relative 'casilla_impuesto.rb'
require_relative 'casilla_juez.rb'
require_relative 'sorpresa_ircarcel.rb'
require_relative 'sorpresa_jugadoriracasilla.rb'
require_relative 'sorpresa_pagarcobrar.rb'
require_relative 'sorpresa_porcasahotel.rb'
require_relative 'sorpresa_porjugador.rb'
require_relative 'sorpresa_salircarcel.rb'
require_relative 'sorpresa_jugadorespeculador.rb'


module Civitas
  class Civitas_juego
    
    attr_reader  :tablero, :gestor_estados, :indice_jugador_actual, :estado, :jugadores, :mazo
   
    
    def initialize(nombres)
    
      @jugadores = Array.new
      @mazo= MazoSorpresas.new
      @estado = Estados_juego::INICIO_TURNO    
      @gestor_estados = Gestor_estados.new
      @indice_jugador_actual = Dado.instance.quien_empieza(nombres.size )
      
      
      for i in 0...nombres.size
        jugador_nuevo = Jugador.new(nombres[i])
        @jugadores.push(jugador_nuevo)
      end

        inicializar_tablero(@mazo)
        inicializar_mazo(@tablero)
     
    
    end
    
    
def inicializar_tablero(mazo)

       @tablero = Tablero.new(8) #Carcel en la 8



      propiedad1 = TituloPropiedad.new("Espania",400,1.2,711,1492,600)
      casilla1 = Casilla_calle.new(propiedad1)
      @tablero.aniade_casilla(casilla1)

      propiedad2 = TituloPropiedad.new("Italia",450,1.2,752,1523,650)
      casilla2 = Casilla_calle.new(propiedad2)
      @tablero.aniade_casilla(casilla2)

      propiedad3 = TituloPropiedad.new("Alemania",700,1.2,900,1800,900)
      casilla3 = Casilla_calle.new(propiedad3)
      @tablero.aniade_casilla(casilla3)

      sorpresa1 = Casilla_sorpresa.new("SORPRESA 1",mazo)
      @tablero.aniade_casilla(sorpresa1)

      propiedad4 = TituloPropiedad.new("Belgica",500,1.2,810,1570,700)
      casilla4 = Casilla_calle.new(propiedad4)
      @tablero.aniade_casilla(casilla4)

      propiedad5 = TituloPropiedad.new("Rusia",440,1.2,748,1510,635)
      casilla5 = Casilla_calle.new(propiedad5)
      @tablero.aniade_casilla(casilla5)

      propiedad6 = TituloPropiedad.new("EEUU",720,1.2,930,1850,925)
      casilla6 = Casilla_calle.new(propiedad6)
      @tablero.aniade_casilla(casilla6)

      propiedad7 = TituloPropiedad.new("Japon",325,1.2,610,1320,510)
      casilla7 = Casilla_calle.new(propiedad7)
      @tablero.aniade_casilla(casilla7)

      propiedad8 = TituloPropiedad.new("Corea del Norte",243,1.2,523,1200,401)
      casilla8 = Casilla_calle.new(propiedad8)
      @tablero.aniade_casilla(casilla8)

      sorpresa2 = Casilla_sorpresa.new("SORPRESA 2",mazo)
      @tablero.aniade_casilla(sorpresa2)

      propiedad9 = TituloPropiedad.new("Grecia",200,1.2,490,1150,350)
      casilla9 = Casilla_calle.new(propiedad9)
      @tablero.aniade_casilla(casilla9)

      propiedad10 = TituloPropiedad.new("Madagascar",350,1.2,620,1330,520)
      casilla10 = Casilla_calle.new(propiedad10)
      @tablero.aniade_casilla(casilla10)

      parking = Casilla.new("parking")
      @tablero.aniade_casilla(parking)

      @tablero.aniade_juez

      propiedad11 = TituloPropiedad.new("El Caribe",750,1.2,970,1200,960)
      casilla11 = Casilla_calle.new(propiedad11)
      @tablero.aniade_casilla(casilla11)

      sorpresa3 = Casilla_sorpresa.new("SOPRESA 3",mazo )
      @tablero.aniade_casilla(sorpresa3)

      impuesto = Casilla_impuesto.new("impuesto",1000)
      @tablero.aniade_casilla(impuesto)

      propiedad12 = TituloPropiedad.new("Holanda",450,1.2,758,1200,642)
      casilla12 = Casilla_calle.new(propiedad12)
      @tablero.aniade_casilla(casilla12)


    end
    
    def inicializar_mazo(tablero)

      especulador = Sorpresa_jugadorespeculador.new(300, "El jugador pasa a ser especulador ^^")
      @mazo.al_mazo(especulador)

      ir_carcel = Sorpresa_ircarcel.new(tablero)
      @mazo.al_mazo(ir_carcel)

      ir_casilla1 = Sorpresa_jugadoriracasilla.new(tablero,13,"Se mueve a la casilla 13")
      @mazo.al_mazo(ir_casilla1)

      ir_casilla2 = Sorpresa_jugadoriracasilla.new(tablero, 6, "Se mueve a la casilla 6")
      @mazo.al_mazo(ir_casilla2)

      ir_casilla3 = Sorpresa_jugadoriracasilla.new(tablero, @tablero.num_casilla_carcel,"Ir a la carcel")
      @mazo.al_mazo(ir_casilla3)

      salir_carcel = Sorpresa_salircarcel.new(@mazo)
      @mazo.al_mazo(salir_carcel)

      pagar = Sorpresa_pagarcobrar.new(-1200,"El jugador debe pagar 1200")
      @mazo.al_mazo(pagar)

      cobrar = Sorpresa_pagarcobrar.new( 1500,"El jugador cobra 1500")
      @mazo.al_mazo(cobrar)


      por_casa_hotel1 = Sorpresa_porcasahotel.new(-250, "EL jugador pagará 250 por cada casa u hotel")
      @mazo.al_mazo(por_casa_hotel1)

      por_casa_hotel2 = Sorpresa_porcasahotel.new( 250, "EL jugador cobrará 250 por cada casa u hotel")
      @mazo.al_mazo(por_casa_hotel2)

      por_jugador1 = Sorpresa_porjugador.new(200, "El jugador cobrará 200 de cada jugador :D")
      @mazo.al_mazo(por_jugador1)

      por_jugador2 = Sorpresa_porjugador.new(-200, "El jugador pagará 200 a cada jugador :(")
      @mazo.al_mazo(por_jugador2)





    end
    
    def contabilizar_pasos_por_salida(jugador_actual)
      if tablero.get_por_salida > 0
        jugador_actual.pasa_por_salida
      end
      
    end
   
    
    def avanza_jugador
      
      jugador_actual= @jugadores[@indice_jugador_actual]
      posicion_actual = jugador_actual.num_casilla_actual
      tirada = Dado.instance.tirar
      posicion_nueva= @tablero.nueva_posicion(posicion_actual,tirada)
      casilla = @tablero.attr_get_casilla(posicion_nueva)
      contabilizar_pasos_por_salida(jugador_actual)
      jugador_actual.mover_a_casilla(posicion_nueva)
      casilla.recibe_jugador(@indice_jugador_actual, @jugadores)
      contabilizar_pasos_por_salida(jugador_actual)
      
    end
    
    def pasar_turno
      @indice_jugador_actual= (@indice_jugador_actual + 1) % @jugadores.size
      puts "Es el turno de: #{@jugadores[@indice_jugador_actual]}"
    end
    
    def siguiente_paso_completado(operacion)
      
      jugador_actual = @jugadores[@indice_jugador_actual]
      @estado = @gestor_estados.siguiente_estado(jugador_actual, @estado, operacion)
      
    end
    
    def siguiente_paso
      
      
      jugador_actual = @jugadores[@indice_jugador_actual]
      contabilizar_pasos_por_salida(jugador_actual)
      operacion = @gestor_estados.operaciones_permitidas(jugador_actual, @estado)      
      if(operacion == Operaciones_juego::PASAR_TURNO )
        pasar_turno
        siguiente_paso_completado(operacion)

      else if(operacion == Operaciones_juego::AVANZAR)
        avanza_jugador
        siguiente_paso_completado(operacion)
           end
      end
      contabilizar_pasos_por_salida(jugador_actual)
      
      return operacion
      
    end
    
=begin
    def operaciones_juego
      @operaciones_juego= Operaciones_juego::AVANZAR
      
    end
=end
    
    def construir_casa(ip)
      return @jugadores[@indice_jugador_actual].construir_casa(ip)
    end
    
    def construir_hotel(ip)
      
      return @jugadores[@indice_jugador_actual].construir_hotel(ip)
    end
    
    def vender(ip)
      
      return @jugadores[@indice_jugador_actual].vender(ip)
    end
    
    def hipotecar(ip)
      
      return @jugadores[@indice_jugador_actual].hipotecar(ip)
    end
    
    def cancelar_hipoteca(ip)
      
      return @jugadores[@indice_jugador_actual].cancelar_hipoteca(ip)
    end
    
    def salir_carcel_pagando
      
       return @jugadores[@indice_jugador_actual].salir_carcel_pagando
    end
    
    def salir_carcel_tirando
      
      return @jugadores[@indice_jugador_actual].salir_carcel_tirando
    end
    
    def final_del_juego
      
      final=false
      for i in 0...@jugadores.size
        if @jugadores[i].saldo <= 0
          final = true
        end
      end
      return final
    end
    
    def ranking
      
      return @jugadores.sort
    end
    
    def comprar
      
      result = false
      jugador_actual = @jugadores[@indice_jugador_actual]
      num_casilla_actual = jugador_actual.num_casilla_actual
      casilla = @tablero.attr_get_casilla(num_casilla_actual)
      titulo = casilla.titulo_propiedad
      result = jugador_actual.comprar(titulo)
      return result
      
    end
    
    def get_casilla_actual
      
      return @tablero.attr_get_casilla(@jugadores[@indice_jugador_actual].num_casilla_actual  )
    end
    
    def get_jugador_actual
      
      return @jugadores[@indice_jugador_actual]
    end
    
    def info_jugador_texto
      
        return get_jugador_actual().to_s
    end
    
    private :avanza_jugador, :contabilizar_pasos_por_salida, :inicializar_mazo, :inicializar_tablero
    
  end #end de class
end #end del modulo