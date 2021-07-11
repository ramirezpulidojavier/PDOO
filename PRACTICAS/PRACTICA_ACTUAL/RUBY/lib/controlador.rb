require_relative 'civitas_juego.rb'
require_relative 'vista_textual.rb'
require_relative 'titulo_propiedad.rb'
require_relative 'casilla.rb'
require_relative 'jugador.rb'
require_relative 'sorpresa.rb'
require_relative 'gestor_estados.rb'
require_relative 'operaciones_juego.rb'
require_relative 'mazo_sorpresas.rb'
require_relative 'tablero.rb'
require_relative 'operacion_inmobiliaria.rb'
require_relative 'gestiones_inmobiliarias.rb'
require_relative 'salidas_carcel.rb'
require_relative 'respuestas.rb'
require_relative 'estados_juego.rb'


module Civitas
  class Controlador
    def initialize(modelo,vista)
      @juego=modelo
      @vista=vista
    end
    
    def juega
      @vista.set_civitas_juego(@juego)
      while(!@juego.final_del_juego)
        cnt = 0
        
        if cnt > 0
          @vista.actualizar_vista
        end
        @vista.pausa
        operacion=@juego.siguiente_paso
        @vista.mostrar_siguiente_operacion(operacion)
        if operacion!=Operaciones_juego::PASAR_TURNO
          @vista.mostrar_eventos()
        end
        
        if(!@juego.final_del_juego)
          if(operacion!=nil)
            case operacion
            when Operaciones_juego::COMPRAR
              if(@vista.comprar==Respuestas::SI)
                @juego.comprar
              end
              @juego.siguiente_paso_completado(Operaciones_juego::COMPRAR)
            when Operaciones_juego::GESTIONAR
              @vista.gestionar
              lista=[GestionesInmobiliarias::VENDER,GestionesInmobiliarias::HIPOTECAR,GestionesInmobiliarias::CANCELAR_HIPOTECA,GestionesInmobiliarias::CONSTRUIR_CASA,GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]
              nuevo=Operacion_inmobiliaria.new(lista[@vista.get_gestion],@vista.get_propiedad)
              case nuevo.gestion
              when GestionesInmobiliarias::VENDER
                @juego.vender(@vista.get_propiedad)
              when GestionesInmobiliarias::HIPOTECAR
                @juego.hipotecar(@vista.get_propiedad)
              when GestionesInmobiliarias::CANCELAR_HIPOTECA
                @juego.cancelar_hipoteca(@vista.get_propiedad)
              when GestionesInmobiliarias::CONSTRUIR_CASA
                @juego.construir_casa(@vista.get_propiedad)
              when GestionesInmobiliarias::CONSTRUIR_HOTEL
                @juego.construir_hotel(@vista.get_propiedad)
              when GestionesInmobiliarias::TERMINAR
                @juego.siguiente_paso_completado(operacion)
              end
            when Operaciones_juego::SALIR_CARCEL
              if(@vista.salir_carcel==Salidas_carcel::PAGANDO)
                @juego.salir_carcel_pagando
              else
                @juego.salir_carcel_tirando
              end
              @juego.siguiente_paso_completado(Operaciones_juego::SALIR_CARCEL)
            end
          end
        end
        if(@juego.final_del_juego)
          puts "El juego ha finalizado debido a que un jugador ha caido en bancarrota. Ranking: "
          for i in 0...juego.ranking.size
            puts @juego.ranking[i]
          end
        end
        cnt = cnt + 1
      end
        
    end
  end
end