# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative ('jugador')

module Civitas
class CivitasJuego

  
  def initialize(nombres)
    
    @gestor_estados = Gestor_estados.new
    @jugadores = Array.new
    @tablero = Tablero.new(3)
    @estado = Estados_juego::INICIO_TURNO
    @indice_jugador_actual = Dado.instance.quien_empieza(nombres.length)
    @mazo = MazoSorpresas.new
    
    for i in (0..nombres.size-1)
            
      nuevo_jugador = Jugador.jugador1(nombres.at(i))
      @jugadores.push(nuevo_jugador)
            
    end
   

    inicializar_mazo_sorpresas(@tablero)
    inicializar_tablero(@mazo)
    
  
    
  end
  
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
    return @jugadores.at(@indice_jugador_actual).cancelar_hipoteca(ip);
  end
  
  def comprar
    res = false
    jugador_actual=@jugadores.get(@indice_jugador_actual)
    num_casilla_act= jugador_actual.num_casilla_actual
    casilla=@tablero.get_casilla(num_casilla_act)
    titulo = casilla.get_titulo_propiedad
    res = jugador_actual.comprar(titulo)
    
    return res
    
  end
  
  def construir_casa(ip)
    return @jugadores.at(@indice_jugador_actual).construir_casa(ip)
  end
  
  def construir_hotel(ip)
    return @jugadores.at(@indice_jugador_actual).construir_hotel(ip)
  end
  
  private
  
  def contabilizar_pasos_por_salida(jugador_actual)
        
    while(@tablero.get_por_salida>0)
      jugador_actual.pasa_por_salida
    end
  end
  
  public
  
  def final_del_juego
        
    for i in (0..@jugadores.size-1)
      
      if @jugadores.at(i).en_bancarrota
        
        return true        
      end
    end
    return false
  end
  
  def get_casilla_actual      
       return @tablero.get_casilla(@jugadores.at(@indice_jugador_actual).num_casilla_actual)
  end

  def get_jugador_actual      
        return @jugadores[@indice_jugador_actual]
  end
  
  def hipotecar(ip)
    return @jugadores.get(@indice_jugador_actual).hipotecar(ip);
  end

  def info_jugador_texto
        
    #nuevo = Jugador.new(@jugadores[@indice_jugador_actual])
    #info = "Nombre del jugador: #{nuevo.nombre} 
    #        Esta en la casilla: #{get_casilla_actual} 
    #        Tiene #{nuevo.propiedades.size} propiedades 
    #        Saldo del jugador: #{nuevo.saldo}" 
        
    #if(nuevo.is_encarcelado)
    #  info += " Esta encarcelado" 
    #else
    #  info += " No esta encarcelado" 
    #
    #end
  
    #return info
     
    return @jugadores.at(@indice_jugador_actual).to_s
    
  end      
  
  private
  
  def inicializar_mazo_sorpresas(tablero)
        
    ir_carcel = Sorpresa.new(TipoSorpresa::IRCARCEL, tablero)
    
    ir_casilla = Sorpresa.new(TipoSorpresa::IRCASILLA, tablero, 6, "Ve a la casilla numero 6")
    ir_casilla2 = Sorpresa.new(TipoSorpresa::IRCASILLA, tablero, 13, "Ve a la casilla numero 13")
    
    librarte_carcel = Sorpresa.new(TipoSorpresa::SALIRCARCEL, @mazo)
    
    paga = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, -150, "Pagas 150")
    cobra = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, 150, "Recibes 150")
    
    paga_edificios = Sorpresa.new(TipoSorpresa::PORCASAHOTEL, -40, "Costes por casas y hoteles")
    cobra_edificios = Sorpresa.new(TipoSorpresa::PORCASAHOTEL, 40, "Beneficios por casas y hoteles")
    
    pagar_a_jugador = Sorpresa.new(TipoSorpresa::PORJUGADOR, -20, "Pagas 20 a cada jugador")
    cobrar_de_jugador = Sorpresa.new(TipoSorpresa::PORJUGADOR, 20, "Recibes 20 de cada jugador")
    
    
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
    casilla1 = Casilla.casilla(propiedad1)
    @tablero.aniade_casilla(casilla1)
    
    propiedad2 = TituloPropiedad.new("Italia",450,1.2,752,1523,650)
    casilla2 = Casilla.casilla(propiedad2)
    @tablero.aniade_casilla(casilla2)
    
    propiedad3 = TituloPropiedad.new("Alemania",700,1.2,900,1800,900)
    casilla3 = Casilla.casilla(propiedad3)
    @tablero.aniade_casilla(casilla3)
    
    propiedad4 = TituloPropiedad.new("Belgica",500,1.2,810,1570,700)
    casilla4 = Casilla.casilla(propiedad4)
    @tablero.aniade_casilla(casilla4)
    
    propiedad5 = TituloPropiedad.new("Rusia",440,1.2,748,1510,635)
    casilla5 = Casilla.casilla(propiedad5)
    @tablero.aniade_casilla(casilla5)
    
    propiedad6 = TituloPropiedad.new("EEUU",720,1.2,930,1850,925)
    casilla6 = Casilla.casilla(propiedad6)
    @tablero.aniade_casilla(casilla6)
    
    propiedad7 = TituloPropiedad.new("Japon",325,1.2,610,1320,510)
    casilla7 = Casilla.casilla(propiedad7)
    @tablero.aniade_casilla(casilla7)
    
    propiedad8 = TituloPropiedad.new("Corea del Norte",243,1.2,523,1200,401)
    casilla8 = Casilla.casilla(propiedad8)
    @tablero.aniade_casilla(casilla8)
    
    propiedad9 = TituloPropiedad.new("Grecia",200,1.2,490,1150,350)
    casilla9 = Casilla.casilla(propiedad9)
    @tablero.aniade_casilla(casilla9)
    
    propiedad10 = TituloPropiedad.new("Madagascar",350,1.2,620,1330,520)
    casilla10 = Casilla.casilla(propiedad10)
    @tablero.aniade_casilla(casilla10)
    
    
    parking = Casilla.new("parking")
    @tablero.aniade_casilla(parking)
    
    
    propiedad11 = TituloPropiedad.new("El Caribe",750,1.2,970,1200,960)
    casilla11 = Casilla.casilla(propiedad11)
    @tablero.aniade_casilla(casilla11)
    
    impuesto = Casilla.new(1000,"impuesto")
    @tablero.aniade_casilla(impuesto)
    
    propiedad12 = TituloPropiedad.new("Chile",450,1.2,758,1200,642)
    casilla12 = Casilla.casilla(propiedad12)
    @tablero.aniade_casilla(casilla12)
    
    sorpresa1 = Casilla.new(mazo, "sorpresa1")
    @tablero.aniade_casilla(sorpresa1)
    
    @tablero.aniade_juez
    
    sorpresa2 = Casilla.new(mazo, "sorpresa2")
    @tablero.aniade_casilla(sorpresa2)
    
    sorpresa3 = Casilla.new(mazo, "sorpresa3")
    @tablero.aniade_casilla(sorpresa3)
  end
  
  def pasar_turno      
        @indice_jugador_actual = (@indice_jugador_actual +1)%@jugadores.size       
  end
 
  def ranking
        
    rank = Array.new
    copia_original = Array.new
        
    for i in (0..@jugadores.size-1)
      copia_original.push(@jugadores[i])
    end  
        
    contador = 0 
        
    while (contador < @jugadores.size)
            
      mayor = 0;
            
      for j in (1..copia_original.size-1)
                
        if(copia_original[mayor].<=>(copia_original[j]) == -1)
          mayor = j               
        end
      end
            
      rank.push(@jugadores[mayor]);
      @jugadores.delete(@jugadores[mayor]);
            
      contador+=1
            
    end
        
        return rank
  end
  
  public

  def salir_carcel_pagando
     
    return @jugadores[@indice_jugador_actual].salir_carcel_pagando
  end
    
  def salir_carcel_tirando
    
    return @jugadores[@indice_jugador_actual].salir_carcel_tirando
  end

  def siguiente_paso_completado(operacion)
     
    @estado = @gestor_estados.siguiente_estado(@jugadores[@indice_jugador_actual], @estado, operacion)
        
  end
    
  def vender(ip)
        
    return @jugadores[@indice_jugador_actual].vender(ip)
        
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


end
end