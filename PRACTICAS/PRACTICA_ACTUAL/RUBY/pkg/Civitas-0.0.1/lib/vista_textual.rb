#encoding:utf-8
require_relative 'operaciones_juego'
require 'io/console'

module Civitas

  class Vista_textual

    def initialize
       @juegoModel
       @igestion = -1
       @ipropiedad = -1
    end
    
    
    def mostrar_estado(estado)
      puts estado
    end

    
    def pausa
      print "Pulsa una tecla: "
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
                          tab+"Valor erróneo")
      return opcion
    end

    
    def comprar
      lista = [Respuestas::NO,Respuestas::SI]
      eleccion=menu("Deseas comprar la calle a la que has llegado?",["No","Si"])
      return lista[eleccion]
    end
    

    def gestionar
      

      lista_s=["Vender","Hipotecar","Cancelar hipoteca","Construir casa","Construir hotel","Terminar"]
      lista_g=[GestionesInmobiliarias::VENDER,GestionesInmobiliarias::HIPOTECAR,GestionesInmobiliarias::CANCELAR_HIPOTECA,GestionesInmobiliarias::CONSTRUIR_CASA,GestionesInmobiliarias::CONSTRUIR_HOTEL,GestionesInmobiliarias::TERMINAR]

      seleccion= menu("Que gestion desea realizar?",lista_s)
      @igestion=seleccion

      if(@igestion != 5)

        propiedades_nombre=[]
        propiedades_titulo=@juegoModel.get_jugador_actual.propiedades

        for i in 0...propiedades_titulo.size() do
          propiedades_nombre.push(propiedades_titulo[i].nombre)
        end
        opcion = menu("Sobre que propiedad?", propiedades_nombre)
        @ipropiedad=opcion
      end
    end

    def get_gestion
      return @igestion
    end

    def get_propiedad
      return @ipropiedad
    end

    def mostrar_siguiente_operacion(operacion)
      
      puts operacion.to_s
    end

    def mostrar_eventos
      
      while(Diario.instance.eventos_pendientes)
        puts Diario.instance.leer_evento
      end
      
    end

    def set_civitas_juego(civitas)
         @juegoModel=civitas
         self.actualizar_vista
    end

    def actualizar_vista
      
      puts @juegoModel.get_jugador_actual.to_s
      puts @juegoModel.get_casilla_actual.to_s
      
      
    end

    def salir_carcel
      titulo = "Elige la forma para intentar salir de la carcel"
      lista = [Salidas_carcel::PAGANDO, Salidas_carcel::TIRANDO]
      opcion = menu(titulo,["Pagando", "Tirando el dado"])
      return lista[opcion]
    end

    
  end

end