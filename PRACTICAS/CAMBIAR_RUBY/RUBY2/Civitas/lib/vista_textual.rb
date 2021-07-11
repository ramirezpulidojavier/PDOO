#encoding:utf-8
require_relative 'respuestas'
require_relative 'salidas_carcel'
require 'io/console'


module Civitas

  class Vista_textual
    def initialize
      @juego_model
      @i_gestion = -1
      @i_propiedad = -1
      @separador = "======================"
    end

      attr_reader :juego_model
    
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

    def salir_carcel

      lista_salidas_carcel = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]
      opcion = menu("Elige la forma para intentar salir de la carcel", ["Pagando","Tirando el dado"])


      return lista_salidas_carcel[opcion]
    end
    def comprar
      lista_respuestas=[Respuestas::NO,Respuestas::SI]
      opcion = menu("¿Deseas comprar la calle a la que has llegado?",["SI","NO"])


      return lista_respuestas[opcion]
    end
    
    def gestionar
      opcion = menu("¿Que gestion inmobiliaria desea hacer?",
        ["VENDER","HIPOTECAR","CANCELAR HIPOTECA","CONSTRUIR CASA","CONSTRUIR HOTEL","CONSTRUIR IMPERIO", "TERMINAR"])

      @i_gestion = opcion

      if(@i_gestion != 5)
        tab = " "
        puts "¿Sobre que propiedad desea realiza la gestion? [0,#{@juegoModel.get_jugador_actual.propiedades.length-1}]"
        @i_propiedad = lee_entero(@juegoModel.get_jugador_actual.propiedades.length,
        "\n"+tab+"Elige la propiedad sobre la que aplicar la gestion: ", tab+"valor erroneo")
      end
    end

    def get_gestion
      return @i_gestion
    end

    def get_propiedad
      return @i_propiedad
    end

    def mostrar_siguiente_operacion(operacion)
      puts "La siguiente operacion que se va a realizar es: #{operacion}"
    end

    def mostrar_eventos
      puts "\nLos eventos pendientes son: "
      while(Diario.instance.eventos_pendientes)

      puts Diario.instance.leer_evento
      end
    end

    def set_civitas_juego(civitas)
         @juego_model=civitas
         self.actualizar_vista
    end

    def actualizar_vista
      puts "#{@juego_model.info_jugador_texto}"
    end
  end
end
