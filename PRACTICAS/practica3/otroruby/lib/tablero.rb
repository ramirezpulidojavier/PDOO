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
    
    @casillas = []
    @casillas.push("salida")
    @por_salida =  0
    @tiene_juez = false
    
  end
  
  private 
  def correcto()
    
    correcto = true
    tamano = @casillas.size
        
        
    if (tamano > @num_casilla_carcel)
            
      return correcto
            
    else
            
      correcto = false 
      return correcto 
            
    end    
  end 
   
  def correcto2(num_casilla)
    
    bueno = true 
        
    if(correcto && (num_casilla >=0 && num_casilla <@casillas.size))
            
            return bueno
            
    else
            
    bueno = false
    return bueno
        
    end
    
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
  
  
  def aniade_casilla(casilla)           #MIRAR LO DE AÑADIR LAS PUTAS CASILLAS JODER
    
    if(@casillas.length == @num_casilla_carcel)
      
      @casillas.push(Casilla.new("Carcel"))
      @casillas.push(casilla)
      
      
    else
     
      @casillas.push(casilla)
 
      if(@casillas.length == @num_casilla_carcel)
      
      @casillas.push(Casilla.new("Carcel"))  
      end
      
      
    end
    
  end
  
  
  attr_reader :casillas
  
  def aniade_juez
    
    if (!@tiene_juez)
      
      @casillas.push(@num_casilla_carcel,"juez")
      @tiene_juez = true
      
    end
    
  end
  
  
  
  def get_casilla(num_casilla)
    
    
    if(correcto2(num_casilla))
      
      return @casillas[num_casilla]
    
    else
      
      return null
    
    end
    
  end
  
  
  
  def nueva_posicion(actual, tirada)
     
        if(!correcto2(actual))
          
          return -1
          
        else
          
          avance = (actual + tirada) % @casillas.length
          
      
          if(actual+tirada != avance)
            @por_salida += 1
          end
          
        end
        
        return avance
        
    
  end



  def calcular_tirada(origen, destino)
    
    tirada = destino - origen
    
    if (tirada < 0)
      
      tirada = (destino - origen) + @casillas.length
      
    end
    
    return tirada
      
  end
  
end
end
  
  
  
  






























  
  
  

  
  
  
  

