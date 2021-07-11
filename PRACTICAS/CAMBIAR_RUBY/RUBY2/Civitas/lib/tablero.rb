module Civitas
  class Tablero
    
    def initialize (num_casilla_carcel)

      if(num_casilla_carcel > 1)
        @num_casilla_carcel = num_casilla_carcel
      else
        @num_casilla_carcel = 1
      end
      salida = Casilla.casilla("Salida")
      @casillas = []
      @casillas << salida
      @por_salida =  0
      @tiene_juez = false

    end
    
    attr_accessor :num_casilla_carcel, :casillas, :por_salida, :tiene_juez
    
    def correcto

    return @casillas.size > @num_casilla_carcel && @tiene_juez
  end
    
    
    def get_por_salida
      if (@por_salida > 0)
        @por_salida = @por_salida -1
        return @por_salida +1
      else
        return @por_salida
      end
    end
    
    def aniade_casilla (casilla)
      carcel = Casilla.casilla("Carcel")

    if(@casillas.length == @num_casilla_carcel)

      @casillas << carcel
      @casillas << casilla


    else

      @casillas << casilla

      if(@casillas.length == @num_casilla_carcel)

      @casillas << carcel
      end


    end
    end
    
    def aniade_juez
      if (!@tiene_juez)
      juez = Casilla.new(@num_casilla_carcel, "Juez")
      aniade_casilla (juez)
      @tiene_juez = true

    end
    end
    
    def get_casilla (numCasilla)
      return @casillas[numCasilla]
    end
    
    def nueva_posicion (actual, tirada)
      if (correcto == false)
        return -1;
      else
        pos = (actual + tirada)%@casillas.size
        
      end
      return pos
    end
    
    def calcular_tirada (origen, destino)
      tirada = destino - origen
      if (tirada < 0)
        tirada = tirada + @casillas.length
      end
      return tirada
    end
    
    def borrar_casilla (ip)
      @casillas.delete_at(ip)
    end
    
    private :correcto
  end
end
