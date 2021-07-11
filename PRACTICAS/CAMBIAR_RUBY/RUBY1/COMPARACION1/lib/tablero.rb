require './tipo_casilla'
require './tipo_sorpresa'
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
  

  private
  def correcto()

    return @casillas.size > @num_casilla_carcel && @tiene_juez
  end

  def correcto2(num_casilla)

    return correcto && num_casilla >=0 && num_casilla < @casillas.size

  end

  public

  attr_reader :num_casilla_carcel



  def get_por_salida

    if(@por_salida > 0)
      aux = @por_salida
      @por_salida-=1
      return aux
    else
      return @por_salida
    end

  end


  def aniade_casilla(casilla)

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


  attr_reader :casillas

  def aniade_juez

    

  end



  def get_casilla(num_casilla)


    if(correcto2(num_casilla))

      return @casillas[num_casilla]

    else

      return nil

    end

  end



  def nueva_posicion(actual, tirada)

        if(!correcto)

          return -1

        else

          avance = (actual + tirada) % @casillas.length


          if(actual+tirada != avance)
            @por_salida += 1
          end

          return avance

        end


  end



  def calcular_tirada(origen, destino)

    tirada = destino - origen

    if (tirada < 0)

      return tirada + @casillas.length
    else
      return tirada
    end

  end

end
end