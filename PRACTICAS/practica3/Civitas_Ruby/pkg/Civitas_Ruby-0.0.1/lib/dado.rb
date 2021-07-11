# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'

module Civitas
  
  class Dado
    include Singleton
    
    @@SalidaCarcel = 5
    
    private
    def initialize
      @random = rand(6) + 1
      @ultimo_resultado = 0
      @debug = false
    end
    
    public
    
    attr_reader :ultimo_resultado
    
    def tirar  
      
      if @debug       
        @ultimo_resultado=1       
      else   
        @ultimo_resultado = rand(6) + 1        
      end
      
      return @ultimo_resultado
      
    end
    
    def salgo_de_la_carcel      
      return tirar >= @@SalidaCarcel    
    end
  
    def quien_empieza(num_jugadores)     
      return rand(num_jugadores)              
    end
  
    def set_debug(d)
      
      @debug = d
      
      if @debug       
        Diario.instance.ocurre_evento("El debug esta activado")         
      else   
        Diario.instance.ocurre_evento("El debug esta desactivado")     
      end
      
    end
   
    
  end
  
end