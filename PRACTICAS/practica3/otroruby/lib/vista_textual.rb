#encoding:utf-8

require_relative 'civitas_juego'
require_relative 'diario'
require_relative 'operaciones_juego'
require_relative 'salidas_carcel'
require_relative 'casilla'
require_relative 'jugador'
require_relative 'titulo_propiedad' 
require 'io/console'

module Civitas

  class Vista_textual
    
    @@separador = "====================="
    def initialize()
      @i_gestion = -1
      @i_propiedad = -1
      
    end
    

    def mostrar_estado(estado)
      puts estado
    end

    
    def pausa
      print "Pulsa una tecla"
      STDIN.getch
      print "\n"
    end

    def lee_entero(max,msg1,msg2)
      ok = false
      begin
        print msg1
        cadena = gets.chomp
        begin
          if (cadena =~ /\A\d+\Z/)
            numero = cadena.to_i
            ok = true
          else
            raise IOError
          end
        rescue IOError
          puts msg2
        end
        if (ok)
          if (numero >= max)
            ok = false
          end
        end
      end while (!ok)

      return numero
    end


    def salir_carcel 
    
      lista_salidas_carcel = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]  
      opcion = menu("Elige la forma para intentar salir de la carcel", ["Pagando","Tirando el dado"])
      
      
      return lista_salidas_carcel[opcion]
    end
    
    

    def menu(titulo,lista)
      tab = "  "
      puts titulo
      index = 0
      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opcion: ",
                          tab+"Valor erroneo")
      return opcion
    end

    
    def comprar
      
      
      lista_respuestas=[Respuestas::NO,Respuestas::SI]
      opcion = menu("¿Deseas comprar la calle a la que has llegado?",["SI","NO"])
      
      
      return lista_respuestas[opcion]
      
    end

    def gestionar
      
      
      lista_gestiones_inmobiliarias = [GestionesInmobiliarias::VENDER,GestionesInmobiliarias::HIPOTECAR,GestionesInmobiliarias::CANCELAR_HIPOTECA,
                                      GestionesInmobiliarias::CONSTRUIR_CASA,GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]
      
      
      opcion = menu("¿Que gestion inmobiliaria desea hacer?",
        ["VENDER","HIPOTECAR","CANCELAR HIPOTECA","CONSTRUIR CASA","CONSTRUIR HOTEL", "TERMINAR"])
      
      @i_gestion = lista_gestiones_inmobiliarias[opcion]
      
      nombres = Array.new
      
          for i in (0..@juegoModel.get_jugador_actual.propiedades.size)
            nombres << @juegoModel.get_jugador_actual.propiedades.at(i).nombre
          end
          
          indice = menu("¿Sobre que propiedad desea realiza la gestion?", nombres)
          
          @i_propiedad = indice
         
    end

    
    attr_reader :i_gestion, :i_propiedad, :juegoModel

    def mostrar_siguiente_operacion(operacion)
     
      puts "La siguiente operacion que se va a realizar es: #{operacion}"
      
    end

    def mostrar_eventos
      
      #puts "\nLos eventos pendientes son: "
      while(Diario.instance.eventos_pendientes)
      
      puts Diario.instance.leer_evento
      end
      
    end

    def set_civitas_juego(civitas)
         @juegoModel=civitas
         #self.actualizar_vista  por esta puta mierda salian 2 jugadores y no 1
    end

    def actualizar_vista
      
      #jugador = @juego_model.get_jugador_actual.to_s
      
      #for i in (0..@juego_model.size)
      
      #propiedades = @juego_model.get_jugador_actual.propiedades[i].to_s
      #end
      
      
      #casilla = @juego_model.get_casilla_actual.to_s
      
      #puts jugador
      #puts propiedades
      #puts casilla
      
      puts "#{@juegoModel.info_jugador_texto}"
      
      
    end

    
  end

end
