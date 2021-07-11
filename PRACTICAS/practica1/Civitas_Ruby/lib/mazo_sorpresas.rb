# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
class MazoSorpresas

  
  def init()
    
    @sorpresas = []
    @cartasEspeciales = []
    @bajarada = false
    @usadas = 0
    
  end
  
  
  
  def initialize

    init()
    @debug = false
   #ultimasorpresa
    
  end
  
  
  def initialize (d)
    
    @debug = d
    init()
    if(@debug==true)
      Diario.instance.ocurre_evento("Debug mode activado")
    else
      Diario.instance.ocurre_evento("Debug mode desactivado")
    end
    
    
  end
  
  
  def al_mazo (s)
    
    if(!@barajada)
      
      @sorpresas.push(s)
      
    end
    
    
  end
  
  
  def siguiente()
    
    if(!@barajada or @usadas == @sorpresas.length)
      
      if(!@debug)
        
        @sorpresas.shuffle
        @barajada = true
        @usadas =  0
        
      end
      
    end
    
    @usadas += 1
    auxiliar = @sorpresas.index(0)
    @sorpresas.push(auxiliar)
    @sorpresas.delete_at(0)
    @ultimasorpresa = auxiliar
    
  end
  
  
  
  
  def inhabilitarcartaespecial(sorpresa)
    
    if (@sorpresas.include?(sorpresa))
            
            @sorpresas.delete(sorpresa)
            @cartasEspeciales.push(sorpresa)
            Diario.instance.ocurre_evento("La carta pasada por argumento ya se encontraba en el mazo, por tanto ha sido eliminada y aniadida a cartasEspeciales")
    end
    
  end
  
  
  
  def habilitarcartaespecial(sorpresa)
    
    if (@cartasEspeciales.include?(sorpresa))
            
            @sorpresas << @cartasEspeciales.at(@cartasEspeciales.index(sorpresa))
            @cartasEspeciales.delete(sorpresa)
            Diario.instance.ocurre_evento("La carta pasada por argumento ya se encontraba en el mazo, por tanto ha sido eliminada y aniadida a sorpresa para ser habilitada para su uso")
    
    end
  
  end
  
  
  
  
end
end