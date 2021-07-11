module Civitas
  class Controlador
    def initialize (_juego, _vista)
      @juego = _juego
      @vista = _vista
    end
    def juega
      @vista.set_civitas_juego(@juego)
      while (!@juego.final_del_juego)
        @vista.actualizar_vista
        @vista.pausa
        operacion = @juego.siguiente_paso
        @vista.mostrar_siguiente_operacion(operacion)
        if (operacion != Operaciones_Juego::PASAR_TURNO)
          @vista.mostrar_eventos
        end
        if (!@juego.final_del_juego)
          if operacion == Operaciones_Juego::COMPRAR

          if (!@vista.juego_model.get_casilla_actual.titulo_propiedad.tiene_propietario && @vista.juego_model.get_casilla_actual.tipo == TipoCasilla::CALLE)
            compra = @vista.comprar

            if compra == Respuestas::SI
              @juego.comprar
              @juego.siguiente_paso_completado(operacion)
            else
              juego.siguiente_paso_completado(operacion)
            end
          else
            if @vista.juego_model.get_casilla_actual.tipo == TipoCasilla::CALLE
              puts "No puedes comprar la propiedad #{@vista.get_casilla_actual.titulo_propiedad.nombre} porque ya tiene propietario.\n"
            else
              puts "\nNo puedes comprar esta casilla porque no es una calle.\n"
            end
            @juego.siguiente_paso_completado(operacion)
          end

        elsif operacion == Operaciones_Juego::GESTIONAR

          lista_gestiones_inmobiliarias = [GestionesInmobiliarias::VENDER, GestionesInmobiliarias::HIPOTECAR,
                                           GestionesInmobiliarias::CANCELAR_HIPOTECA, GestionesInmobiliarias::CONSTRUIR_CASA,
                                           GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]


          @vista.gestionar
          gestion = @vista.gestion
          propiedad = @vista.propiedad

          g_inmobiliaria = lista_gestiones_inmobiliarias[gestion]
          o_inmobiliaria = GestionesInmobiliarias.new(g_inmobiliaria, propiedad)

          if o_inmobiliaria == GestionesInmobiliarias::VENDER
            @juego.vender(propiedad)
          elsif o_inmobiliaria == GestionesInmobiliarias::HIPOTECAR
            @juego.hipotecar(propiedad)
          elsif o_inmobiliaria == GestionesInmobiliarias::CANCELAR_HIPOTECA
            @juego.cancelar_hipoteca(propiedad)
          elsif o_inmobiliaria == GestionesInmobiliarias::CONSTRUIR_CASA
            @juego.construir_casa(propiedad)
          elsif o_inmobiliaria == GestionesInmobiliarias::CONSTRUIR_HOTEL
            @juego.construir_hotel(propiedad)
          elsif o_inmobiliaria== GestionesInmobiliarias::TERMINAR
            @juego.siguiente_paso_completado(Operaciones_Juego::GESTIONAR)
          end


        elsif operacion == Operaciones_Juego::SALIR_CARCEL

          salida = @vista.salir_carcel

          if salida == SalidasCarcel::PAGANDO
            @vista.juego_model.salir_carcel_pagando
          else

            @vista.juego_model.salir_carcel_tirando
          end

          @vista.juego_model.siguiente_paso_completado(Operaciones_Juego::SALIR_CARCEL)

        end
        end
      end
      ranking = @juego.ranking
      puts ranking
    end
  end
end
