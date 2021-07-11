module Civitas
  class Tablero
    attr_accessor :numCasillaCarcel, :casillas, :porSalida, :tieneJuez
    def initialize (carcel, casillas, salida, juez)
      @numCasillaCarcel = carcel
      @casillas = Array.new
      for i in 0 .. casillas.length
        @casillas.push(casillas[i])
      end
      @porSalida = salida
      @tieneJuez = juez
    end
    
    def correcto
      correct = true
      if(@casillas.length <= @numCasillaCarcel)
        correct = false
      end
      if (@tieneJuez == false)
        correct = false
      end
      return correct
    end
    
    def getCarcel
      return @numCasillaCarcel
    end
    
    def getPorSalida
      if (@porSalida > 0)
        @porSalida = @porSalida -1
        return @porSalida +1
      else
        return @porSalida
      end
    end
    
    def aniadeCasilla (casilla)
      if(@casillas == nil)
        @casillas = Array.new
      end
      @casillas.push(casilla)
    end
    
    def aniadeJuez
      if (@tieneJuez == false)
        @juez.setNombre("Juez")
        @casillas.push(@juez)
        @tieneJuez = true
      end
    end
    
    def getCasilla (numCasilla)
      return @casillas[numCasilla]
    end
    
    def nuevaPosicion (actual, tirada)
      if (correcto == false)
        return -1;
      else
        @pos = actual + tirada
        if (@pos > @casillas.length)
          @pos = @pos - @casillas.length
        end
      end
      return @pos
    end
    
    def calcularTirada (origen, destino)
      @tirada = destino - origen
      if (tirada < 0)
        @tirada = @tirada + @casillas.length
      end
      return @tirada
    end
    
    def borrar_casilla (ip)
      @casillas.delete_at(ip)
    end
    
    private :correcto
  end
end
