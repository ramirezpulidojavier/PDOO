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
    
    while !@juego.final_del_juego

      cnt = 0 
      if cnt > 0 
        @vista.actualizar_vista
      end
      
      @vista.pausa
      operacion = @juego.siguiente_paso
      @vista.mostrar_siguiente_operacion(operacion)

      if operacion != Operaciones_Juego::PASAR_TURNO
        @vista.mostrar_eventos
      end

      if !@juego.final_del_juego

        if operacion == Operaciones_Juego::COMPRAR
          
          if !@vista.juegoModel.num_casilla_actual.titulo_propiedad.tiene_propietario && @vista.juegoModel.num_casilla_actual.tipo == TipoCasilla::CALLE

            compra = @vista.comprar

              if compra == Respuestas::SI
             
                @juego.comprar
                @juego.siguiente_paso_completado(operacion)
              else
                @juego.siguiente_paso_completado(operacion)
              end
          else
          
            puts "No puedes comprar la propiedad #{@vista.juegoModel.num_casilla_actual.titulo_propiedad.nombre} porque ya tiene propietario."
            @juego.siguiente_paso_completado(operacion)
          end
        end
            
        elsif operacion == Operaciones_Juego::GESTIONAR

          lista_gestiones_inmobiliarias = [GestionesInmobiliarias::VENDER, GestionesInmobiliarias::HIPOTECAR,
                                           GestionesInmobiliarias::CANCELAR_HIPOTECA, GestionesInmobiliarias::CONSTRUIR_CASA,
                                          GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]
          
          
          @vista.gestionar
          gestion = @vista.i_gestion
          propiedad = @vista.i_propiedad
          g_inmobiliaria = lista_gestiones_inmobiliarias [gestion]
          o_inmobiliaria = OperacionInmobiliaria.new(g_inmobiliaria, propiedad)
          
          if o_inmobiliaria.gestion == GestionesInmobiliarias::VENDER
            @juego.vender(propiedad)
          elsif o_inmobiliaria.gestion == GestionesInmobiliarias::HIPOTECAR
            @juego.hipotecar(propiedad)
          elsif o_inmobiliaria.gestion == GestionesInmobiliarias::CANCELAR_HIPOTECA
            @juego.cancelar_hipoteca(propiedad)
          elsif o_inmobiliaria.gestion == GestionesInmobiliarias::CONSTRUIR_CASA
            @juego.construir_casa(propiedad)
          elsif o_inmobiliaria.gestion == GestionesInmobiliarias::CONSTRUIR_HOTEL
            @juego.construir_hotel(propiedad)
          elsif o_inmobiliaria.gestion == GestionesInmobiliarias::TERMINAR
            @juego.siguiente_paso_completado(operacion)
          end
     

        elsif operacion == Operaciones_Juego::SALIR_CARCEL

          salida = @vista.salir_carcel

          if salida == SalidasCarcel::PAGANDO
            @juego.salir_carcel_pagando
          else 
            
            @juego.salir_carcel_tirando
          end

          @juego.siguiente_paso_completado(operacion)

        end
        cnt +=1
      end      
      
    aux = @juego.ranking
      puts aux
    end
    
  end

end


 






