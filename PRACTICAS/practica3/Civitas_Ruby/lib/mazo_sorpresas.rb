# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require './diario'
require './tipo_sorpresa'
require './sorpresa'

module Civitas
  
  class MazoSorpresas
    
    def initialize(booleano = false)
      @sorpresas = []
      @cartas_especiales = []
      @barajada = false
      @usadas = 0
      @debug = booleano
      @ultima_sorpresa = nil # asi estaba antes Sorpresa.new(TipoSorpresa::IRCARCEL)
      
      if @debug
        Diario.instance.ocurre_evento("El modo debug esta activado")
      else
        Diario.instance.ocurre_evento("El modo debug esta desactivado")
      end
      
    end
    
    attr_reader :ultima_sorpresa
    
    def al_mazo(sorpresa)
      
      if !@barajada        
        @sorpresas << sorpresa       
      end
      
    end
    
    def siguiente
      
      if !@debug && (@usadas == @sorpresas.size || !@barajada)
        
        @sorpresas.shuffle
        @usadas=0
        @barajada =true
      
      end 
      
      @usadas += 1
        
      @ultima_sorpresa = @sorpresas.at(0)
        
      for i in(1..@sorpresas.size-1)
        @sorpresas[i-1] = @sorpresas.at(i)
      end
        
      @sorpresas[@sorpresas.size-1] = @ultima_sorpresa
        
      return @ultima_sorpresa
        
      end
    
    def inhabilitar_carta_especial(sorpresa)
     
        if @sorpresas.include?(sorpresa)
          
          @cartas_especiales << sorpresa          
          Diario.instance.ocurre_evento("Se ha borrado #{sorpresa.to_s} y se ha pasado al mazo de cartasEspeciales")         
          @sorpresas.delete(sorpresa)      
        
        end
      
    end
    
    def habilitar_carta_especial(sorpresa)
     
        if @cartas_especiales.include?(sorpresa)
          
          @sorpresas << sorpresa
          Diario.instance.ocurre_evento("Se ha borrado #{sorpresa.to_s} y se ha pasado al mazo de sorpresas")
          @cartas_especiales.delete(sorpresa)
          
        end
      
    end
    
  end
  
end