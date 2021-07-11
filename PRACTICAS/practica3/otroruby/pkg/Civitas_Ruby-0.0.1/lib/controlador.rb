# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


module Civitas

class Controlador


  def initialize(juego, vista)

    @juego = juego
    @vista = vista

  end

  def juega()

    @vista.set_civitas_juego(@juego)
    lista_salidas_carcel = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]  #SE LLAMA USANDO: lista_salidas_carcel[1]
    
    while !@juego.final_del_juego

      @vista.actualizar_vista
      @vista.pausa
      operacion = @juego.siguiente_paso
      @vista.mostrar_siguiente_operacion(operacion)

      if operacion != Operaciones_Juego::PASAR_TURNO
        @vista.mostrar_eventos
      end

      if !@juego.final_del_juego

        if operacion == Operaciones_Juego::COMPRAR

          compra = @vista.comprar

          if compra == lista_respuestas[1]
            @juego.comprar
            @juego.siguiente_paso_completado(operacion)
          end


        elsif operacion == Operaciones_Juego::GESTIONAR

          @vista.gestionar
          gestion = @vista.getGestion
          propiedad = @vista.getPropiedad
          g_inmobiliaria = lista_gestiones_inmobiliarias[gestion]
          o_inmobiliaria = OperacionInmobiliaria.new(g_inmobiliaria, propiedad)

          if o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.vender(propiedad)
          elsif o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.hipotecar(propiedad)
          elsif o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.cancelar_hipoteca(propiedad)
          elsif o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.construir_casa(propiedad)
          elsif o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.construir_hotel(propiedad)
          elsif o_inmobiliaria.gestion == lista_gestiones_inmobiliarias[0]
            @juego.siguiente_paso_completado(operacion)
          end


        elsif operacion = Operaciones_Juego::SALIR_CARCEL

          salida = @vista.salir_carcel

          if salida == lista_salidas_carcel[0]
            @juego.salir_carcel_pagando
          elsif salida == lista_salidas_carcel[1]
            @juego.salir_carcel_tirando
          end

          @juego.siguiente_paso_completado(operacion)

        end

      else

        @juego.ranking

      end



    end


  end





end

end