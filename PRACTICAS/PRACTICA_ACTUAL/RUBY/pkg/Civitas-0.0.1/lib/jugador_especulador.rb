# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'jugador.rb'

module Civitas
  class Jugador_especulador < Jugador
     @@casas_max = 8
     @@casas_por_hotel = 4
     @@hoteles_max = 8
     
    attr_accessor :fianza
    
    def initialize(fianza)
     
      @fianza=fianza
    end
 
    #Override
    def self.copia(otro,fianza)
      es=new(fianza)
      es.copia(otro)
      for i in otro.propiedades
        i.actualiza_propietario_por_conversion(es)
      end
      es
    end
    
    private_class_method :new
    
#    def actualiza_propietario_por_conversion(jugador)
#      
#      for i in jugador.propiedades
#        i.actualiza_propietario_por_conversion(self)
#      end
#      
#    end
    
    def to_s
      return super + "  .Su fianza es de #{@fianza} ."
      
    end
    
    #Override
    def paga_impuesto(cantidad)
      if @encarcelado
        return false
      else 
        paga(cantidad/2)   
      end 
    end
    
    #Override
     def construir_casa(ip)
      result = false
      if(@encarcelado)
        return result
      end
      if(!@encarcelado)
        
        existe = existe_la_propiedad(ip)
        
        if(existe)
          propiedad=@propiedades[ip]
          puedo_edificar = puedo_edificar_casa(propiedad)
          
        
  
          if(puedo_edificar)
            result = propiedad.construir_casa(self) && propiedad.construir_casa(self) 
          end
          
          
        end
      end
      
      return result
      
    end
    
     #Override
      def construir_hotel(ip)
      
      result = false
      if(@encarcelado)
        return result
      end
      
      if(existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        puedo_edificar_hotel = puedo_edificar_hotel(propiedad)
        precio = propiedad.precio_edificar
        
        if(puedo_gastar(precio) && propiedad.num_hoteles < @@hoteles_max && propiedad.num_casas >= @@casas_por_hotel)
          puedo_edificar_hotel = true
        end
        
        if(puedo_edificar_hotel)
          result = propiedad.construir_hotel(self) && propiedad.construir_hotel(self)
          
          casas_por_hotel = @@casas_por_hotel
          propiedad.derruir_casas(casas_por_hotel, self)
          
          Diario.instance.ocurre_evento("El jugador "+@nombre.to_s+" construye hotel en la propiedad "+ip.to_s)
        end
      
      end
      
      return result
      
    end
    
     #Override 
    def encarcelar(num_casilla_carcel)
      if debe_ser_encarcelado
        mover_a_casilla(num_casilla_carcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido trasladado a la carcel.")
      else
         Diario.instance.ocurre_evento("El jugador #{@nombre} no ha sido trasladado a la carcel.")
      end
      return @encarcelado
    end
    
    #Override
     def debe_ser_encarcelado
      if @encarcelado
        return false
      else
         if tiene_salvoconducto
           perder_salvoconducto()
           Diario.instance.ocurre_evento("El jugador #{@nombre} no debe ser encarcelado porque tiene salvoconducto")
           return false
         else 
                puts "Quieres pagar la fianza y evitas la carcel? Si - No"
                respuesta = gets.chomp
                if(respuesta == "Si" || respuesta == "si" || respuesta == "SI" || respuesta == "sI")
                  this.paga(@fianza)
                  return false
                end     
             end
         end
         return true 
      end
    
    
     #Override
     def puede_salir_carcel_pagando
      
      return @saldo > @fianza
    end
    
     #Override
    def salir_carcel_pagando
      result = false
      if(puede_salir_carcel_pagando && @encarcelado)
        paga(@fianza)
        @encarcelado = false
        Diario.instance.ocurre_evento"El jugador #{@nombre} paga para salir de la carcel"
        result = true
      end
      return result
    end
    
    
    
  end
end
