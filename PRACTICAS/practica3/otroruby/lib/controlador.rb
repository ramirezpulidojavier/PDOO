# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative 'civitas_juego'
require_relative 'operacion_inmobiliaria'
require_relative 'operaciones_juego'
require_relative 'respuestas'
require_relative 'gestiones_inmobiliarias'
require_relative 'salidas_carcel'



module Civitas

class Controlador


  def initialize(juego, vista)

    @juego = juego
    @vista = vista

  end

  def juega

    @vista.set_civitas_juego(@juego)
    
    while !@vista.juegoModel.final_del_juego

      @vista.actualizar_vista
      @vista.pausa
      operacion = @vista.juegoModel.siguiente_paso
      @vista.mostrar_siguiente_operacion(operacion)

      if operacion != Operaciones_Juego::PASAR_TURNO
        @vista.mostrar_eventos
      end

      if !@vista.juegoModel.final_del_juego

        if operacion == Operaciones_Juego::COMPRAR

          compra = @vista.comprar

          if compra == Respuestas::SI
             
            @vista.juegoModel.comprar
  
          end

          @vista.juegoModel.siguiente_paso_completado(Operaciones_Juego::COMPRAR)
        elsif operacion == Operaciones_Juego::GESTIONAR

          #lista_gestiones_inmobiliarias = [GestionesInmobiliarias::VENDER, GestionesInmobiliarias::HIPOTECAR,
          #                                 GestionesInmobiliarias::CANCELAR_HIPOTECA, GestionesInmobiliarias::CONSTRUIR_CASA,
          #                                 GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]
          
          
          @vista.gestionar
          movimiento = OperacionInmobiliaria.new(@vista.i_gestion, @vista.i_propiedad)
          
          if movimiento.gestion == GestionesInmobiliarias::VENDER
            @vista.juegoModel.vender(movimiento.num_propiedad)
          elsif movimiento.gestion == GestionesInmobiliarias::HIPOTECAR
            @juego.hipotecar(movimiento.num_propiedad)
          elsif movimiento.gestion == GestionesInmobiliarias::CANCELAR_HIPOTECA
            @juego.cancelar_hipoteca(movimiento.num_propiedad)
          elsif movimiento.gestion == GestionesInmobiliarias::CONSTRUIR_CASA
            @juego.construir_casa(movimiento.num_propiedad)
          elsif movimiento.gestion == GestionesInmobiliarias::CONSTRUIR_HOTEL
            @juego.construir_hotel(movimiento.num_propiedad)
          elsif movimiento.gestion == GestionesInmobiliarias::TERMINAR
            @juego.siguiente_paso_completado(Operaciones_Juego::GESTIONAR)
          end


        elsif operacion == Operaciones_Juego::SALIR_CARCEL

          salida = @vista.salir_carcel

          if salida == SalidasCarcel::PAGANDO
            @vista.juegoModel.salir_carcel_pagando
          else 
            
            @vista.juegoModel.salir_carcel_tirando
          end

          @vista.juegoModel.siguiente_paso_completado(Operaciones_Juego::SALIR_CARCEL)

        end

      end
    end
        @vista.juegoModel.ranking

      end



    end


  end






