module Civitas
  class Controlador
    def initialize (_juego, _vista)
      @juego = _juego
      @vista = _vista
    end
    def juega
      @vista.setCivitasJuego(@juego)
      while (!@juego.finalDelJuego)
        @vista.actualizarVista
        @vista.pausa
        operacion = @juego.siguientePaso
        @vista.mostrarSiguienteOperacion(operacion)
        if (operacion != OperacionesJuego::PASAR_TURNO)
          @vista.mostrarEventos
        end
        if (!@juego.finalDelJuego)
          case (operacion)
          when OperacionesJuego::COMPRAR
            respuesta = @vista.comprar
            if (respuesta == Respuestas::SI)
              @juego.comprar
              @juego.siguientePasoCompletado(operacion)
            else
              @juego.siguientePasoCompletado(operacion)
            end
          when OperacionesJuego::GESTIONAR
            @vista.gestionar
            gestiones = [OperacionesInmobiliarias::VENDER, OperacionesInmobiliarias::HIPOTECAR, OperacionesInmobiliarias::CANCELAR_HIPOTECA, OperacionesInmobiliarias::CONSTRUIR_CASA, OperacionesInmobiliarias::CONSTRUIR_HOTEL, OperacionesInmobiliarias::TERMINAR]
            op_gestionada = gestiones[@vista.getGestion]
            ip_propiedad = @vista.getPropiedad
            op_inmobiliaria = OperacionInmobiliaria.new(op_gestionada, ip_propiedad)
            
            if (op_gestionada == OperacionesInmobiliarias::TERMINAR)
              @juego.siguientePasoCompletado(operacion)
            else
              puts "op-gesti #{op_gestionada}"
              case (op_gestionada)
              when OperacionesInmobiliarias::VENDER
                @juego.vender(ip_propiedad)
              when OperacionesInmobiliarias::HIPOTECAR
                @juego.hipotecar(ip_propiedad)
              when OperacionesInmobiliarias::CANCELAR_HIPOTECA
                @juego.cancelarHipoteca(ip_propiedad)
              when OperacionesInmobiliarias::CONSTRUIR_CASA
                @juego.construirCasa(ip_propiedad)
              when OperacionesInmobiliarias::CONSTRUIR_HOTEL
                @juego.construirHotel(ip_propiedad)
              end
              @juego.siguientePasoCompletado(operacion)
            end
          when OperacionesJuego::SALIR_CARCEL
            metodo = @vista.salirCarcel
            if (metodo == SalidasCarcel::PAGANDO)
              @juego.salirCarcelPagando
            else
              @juego.salirCarcelTirando
            end
              @juego.siguientePasoCompletado(operacion)
          else
            # no hace nada
          end
        end
      end
      ranking = @juego.ranking
      puts ranking
    end
  end
end
