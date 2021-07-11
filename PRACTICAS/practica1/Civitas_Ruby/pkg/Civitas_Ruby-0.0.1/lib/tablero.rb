# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
# encoding:utf-8

module Civitas
  tipo_casilla.rb
  casilla.rb
  class Tablero
    def initialize(n)
      
        if n>=1
          @numCasillaCarcel = n
        else
          @numCasillaCarcel = 1
        end
        
        s = casilla.new("salida", TipoCasilla::DESCANSO)
        @casillas = []
        @casillas.push(s)
        
        @porSalida = 0
        @tieneJuez = false
        
    end
    
    def correcto
      
      return @casillas.size > @numCasillaCarcel && @tieneJuez
      
    end
    
    def correcto(numCasilla)
      
      return correcto() && (numCasilla >= 0 && numCasilla < @casillas.size)
      
    end
    
    def attr_reader_carcel
      
      return numCasillaCarcel
      
    end
    
    def attr_reader_porsalida
      
      return porSalida
      
    end
    
    def añadecasilla(casilla)
      
      carcel = casilla.new("Carcel", TipoCasilla::DESCANSO)
      
      if @casillas.size == numCasillaCarcel
        @casillas.push(carcel)
        @casillas.push(casilla)
      else
        @casillas.push(casilla)
        if @casillas.size == numCasillaCarcel
          @casillas.push(carcel)
        end
      end
      
    end
    
    def añadejuez
      if @tieneJuez
        juez = casilla.new("Juez", TipoCasilla::JUEZ)
        añadecasilla(juez)
        @tieneJuez = true
      end
    end
    
    def attr_reader_tamaño
      
      return @casillas.size
      
    end
    
    def attr_reader_casilla(num)
      
      if correcto(num)
        return @porSalida
      else
        return null
      end
      
    end 
    
  end
end