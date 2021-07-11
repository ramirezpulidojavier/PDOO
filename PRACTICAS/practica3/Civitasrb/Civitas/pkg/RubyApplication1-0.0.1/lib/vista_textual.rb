#encoding:utf-8
require 'io/console'

module Civitas

  class Vista_textual
    def initialize
      @juegoModel
      @iGestion = -1
      @iPropiedad = -1
      @separador = "======================"
      # @in 
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



    def menu(titulo,lista)
      tab = "  "
      puts titulo
      index = 0
      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo")
      return opcion
    end

    def salirCarcel
      titulo = "Elige la forma para intentar salir de la carcel"
      lista = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]
      opcion = menu(titulo,lista)
      return lista[opcion]
    end
    
    def comprar
      titulo = "Elige si desea comprar la calle"
      lista = ["NO", "SI"]
      opcion = menu(titulo, lista)
      if (opcion == 1)
        lista[opcion] = Respuestas::SI
      else
        lista[opcion] = Respuestas::NO
      end
      return lista[opcion]
    end
    
    def gestionar
      lista_gestiones = ["Vender", "Hipotecar", "Cancelar hipoteca", "Construir casa", "Construit hotel", "Terminar"]
      @iGestion = menu("Elige una gestion inmobiliaria", lista_gestiones)
      if (@iGestion != 5)
        tab = "  "
        puts "Elige la propiedad sobre la que aplicar la operacion inmobiliaria [0,#{@juegoModel.getJugadorActual.propiedades.length-1}]"
        @iPropiedad = lee_entero(@juegoModel.getJugadorActual.propiedades.length,
                          "\n"+tab+"Elige la propiedad sobre la que aplicar la gestion inmobiliaria: ",
                          tab+"Valor erróneo")
      end
    end

    def getGestion
      return @iGestion
    end

    def getPropiedad
      return @iPropiedad
    end

    def mostrarSiguienteOperacion(operacion)
      puts operacion
    end

    def mostrarEventos
      while(Diario.instance.eventos_pendientes)
        puts Diario.instance.leer_evento
      end
    end

    def setCivitasJuego(civitas)
         @juegoModel=civitas
         self.actualizarVista
    end

    def actualizarVista
      puts @juegoModel.getJugadorActual.toString
      puts @juegoModel.getCasillaActual.toString
    end
  end
end
