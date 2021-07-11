# encoding: utf-8
require_relative 'casilla.rb'
require_relative 'casilla_juez.rb'

module Civitas
  class Tablero
    
    attr_reader  :num_casilla_carcel, :casillas
    attr_accessor :tiene_juez
    
    def initialize(n)
      @num_casilla_carcel=1
      if n>1
        @num_casilla_carcel=n
      end
      @casillas=[Casilla.new("Salida")]
      @por_salida=0
      @tiene_juez=false
    end


    def correcto(num_casilla=0)
      operacion=false
      if num_casilla==0
        if @casillas.size>=num_casilla_carcel&&tiene_juez
          operacion=true
        end
      else
        if @casillas.size>=num_casilla_carcel&&tiene_juez&&num_casilla>=0&&num_casilla<casillas.size
          operacion=true
        end
      end              
      return operacion
    end

    def attr_get_carcel                                                
      return @num_casilla_carcel
    end

    def get_por_salida
      if @por_salida>0
        @por_salida-=1
        return @por_salida+1
      end
      return @por_salida                                               
    end

    def aniade_casilla(casilla)
      if @casillas.size==@num_casilla_carcel
        @casillas.push(Casilla.new("Carcel"))                          
      end
      @casillas.push(casilla)
      if @casillas.size==@num_casilla_carcel
        @casillas.push(Casilla.new("Carcel"))
      end
    end

    def aniade_juez
      if !@tiene_juez
        @casillas.push(Casilla_juez.new("Juez", @num_casilla_carcel ) )
        @tiene_juez=true
      end
    end

    def attr_get_casilla(num_casilla)
      if correcto(num_casilla)
        return @casillas[num_casilla]
     end
      return nil
    end

    def nueva_posicion(actual,tirada)
      nactual = -1
      if correcto()
        nactual=(actual+tirada)%(@casillas.size)
        if nactual!=actual+tirada
          @por_salida+=1
        end
      end
      return nactual
    end

    def calcular_tirada(origen,destino)
      distancia=destino-origen
      if distancia<0
        distancia=distancia+@casillas.size        
      end
      distancia
    end
  end
end