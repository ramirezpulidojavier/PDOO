# encoding: utf-8
require_relative 'tablero.rb'
require_relative 'dado.rb'
require_relative 'mazo_sorpresas.rb'
require_relative 'estados_juego.rb'
require_relative 'operaciones_juego.rb'
require_relative 'jugador.rb'
require_relative 'casilla.rb'
require_relative 'civitas_juego.rb'
require_relative 'sorpresa.rb'



module Civitas
  class TestP1
    def initialize

    end
    
    def self.main
#      #1
#      j0=j1=j2=j3=0
#      for i in 0..99
#        case Dado.instance.quien_empieza(4)
#        when 0
#          j0+=1
#        when 1
#          j1+=1
#        when 2
#          j2+=1
#        when 3
#          j3+=1
#        end
#      end
#      puts "#{j0} #{j1} #{j2} #{j3}"
#      
#      #2
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      Dado.instance.attr_set_debug(true)
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      Dado.instance.attr_set_debug(false)
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      puts Dado.instance.tirar().to_s+" "
#      
#      #3
#      print Dado.instance.attr_get_ultimo_resultado.to_s+" "
#      print Dado.instance.tirar().to_s+" "
#      print Dado.instance.attr_get_ultimo_resultado.to_s+" "
#      print Dado.instance.salgo_de_la_carcel.to_s+" "
#      puts Dado.instance.salgo_de_la_carcel.to_s+" "
#      
#      #4
#      
#      #5
#      impuesto=Sorpresa.new
#      alquiler=Sorpresa.new
#      mazo=MazoSorpresas.new
#      mazo.al_mazo(impuesto)
#      mazo.al_mazo(alquiler)
#      print mazo.siguiente
#      print mazo.siguiente.to_s+"  "
#      mazo.inhabilitar_carta_especial(alquiler)             
#      print mazo.siguiente
#      print mazo.siguiente.to_s+"  "
#      mazo.habilitar_carta_especial(alquiler)
#      print mazo.siguiente
#      puts mazo.siguiente
#      
#      #6
#      print Diario.instance.eventos_pendientes.to_s+" "
#      print Diario.instance.leer_evento.to_s+" "
#      print Diario.instance.leer_evento.to_s+" "
#      print Diario.instance.leer_evento.to_s+" "
#      print Diario.instance.leer_evento.to_s+" "
#      print Diario.instance.leer_evento.to_s+" "
#      puts Diario.instance.eventos_pendientes.to_s+" "
#      
#      #7
#      tablero=Tablero.new(3)
#      tablero.añade_casilla(Casilla.new("Ciudad"))
#      tablero.añade_casilla(Casilla.new("Playa"))
#      tablero.añade_casilla(Casilla.new("Campo"))
#      tablero.añade_casilla(Casilla.new("Granada"))
#      tablero.añade_juez
#      print tablero.attr_get_carcel.to_s+"  "
#      print tablero.nueva_posicion(0,9).to_s+" "
#      print tablero.nueva_posicion(2,Dado.instance.tirar).to_s+" "
#      print tablero.nueva_posicion(Dado.instance.attr_get_ultimo_resultado,Dado.instance.tirar).to_s+" "
#      print tablero.nueva_posicion(Dado.instance.attr_get_ultimo_resultado,Dado.instance.tirar).to_s+" "
#      print tablero.calcular_tirada(3,2).to_s+" "
#     
#             private initialize
#             @diario = Diario.new
#             
#             diario.OcurreEvento("hola")
#             diario.leerevento
#     
#    para llamar a un modulo fuera de este se usa: tablerito =  Civitas::tablero.new
#                                                   tablerito.añadejuez
#                                                   quienempieza = Civitas::Dado.quienempieza
#    
      #COMENZAMOS TEST P2

      
#      
#      jugadores = Array.new
#      jugadores.push("paquito")
#      jugadores.push("joselito")
#      jugadores.push("currito")
#
#     
#      partida = Civitas_juego.new(jugadores)
#      puts partida.get_jugador_actual
#      
#      puts partida.get_casilla_actual
#      partida.get_jugador_actual.recibe(5500)
#      puts partida.info_jugador_texto
#       partida.pasa_turno
#      puts partida.get_jugador_actual
#      partida.get_jugador_actual.paga(4500)
#      puts partida.info_jugador_texto
#      partida.get_jugador_actual.mover_a_casilla(4)
#      puts partida.get_casilla_actual
#      
#      pruebas = Array.new
#      sorpresa1 = Sorpresa.sorpresa_carcel(TipoSorpresa::IRCARCEL, partida.tablero)
#      sorpresa2 = Sorpresa.sorpresa_resto(TipoSorpresa::PAGARCOBRAR, 13000, "texto")
#      sorpresa3 = Sorpresa.sorpresa_evitacarcel(TipoSorpresa::SALIRCARCEL,partida.mazo)
#      pruebas.push(sorpresa1)
#      pruebas.push(sorpresa2)
#      
#      puts partida.get_jugador_actual
#      sorpresa2.aplicar_a_jugador(0,partida.jugadores)
#      
#      puts partida.jugadores[0]
#      sorpresa3.aplicar_a_jugador(0, partida.jugadores)
#      sorpresa1.aplicar_a_jugador(0,partida.jugadores)
#      puts partida.get_casilla_actual
#      puts partida.jugadores[0]
#      sorpresa1.aplicar_a_jugador(0,partida.jugadores)
#      puts partida.jugadores[0]
#            
   end
  end
  
  TestP1.main
  
end
