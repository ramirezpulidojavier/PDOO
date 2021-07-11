# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require 'singleton'
module Civitas

class Dado
  
  include Singleton
  
  #Atributo de clase
  @@SalidaCarcel = 5
  
  
  
  #Constructor privado sin argumentos
  def initialize
    
    @debug = false
    @ulimoresultado = 0
    @random = rand(6) + 1
    
  end
  
  #Metodos de instancia
  def tirar
    
    if (@debug==false)
      
      @ultimoresultado = rand (1..6)
      return @ultimoresultado
      
    else
    
      return 1
      
    end
    
  end
  
  
  def salgodelacarcel
    
    @resultado = tirar
    
    if (@resultado >= 5)
      @sale = true
    else
      @sale = false
    end
    
    return @sale
    
  end
  
  
  
  def quienempieza(n)
    
    return rand (n)
    
  end
  
  
  def setdebug (d)
    
    if(d == true)
      @debug = true
      Diario.instance.ocurre_evento("Debug mode activado")
    else
      @debug = false
      Diario.instance.ocurre_evento("Debug mode desactivado")
    end
    
  end
  
  
  def getultimoresultado
    
    return @ultimoresultado
    
  end
  
  
  
  
end
end