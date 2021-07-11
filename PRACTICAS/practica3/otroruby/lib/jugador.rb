# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'diario'
require_relative 'titulo_propiedad.rb'

module Civitas

  class Jugador
    
    @@Casas_max = 4
    @@Casas_por_hotel = 4
    @@Hoteles_max = 4
    @@Paso_por_salida = 1000
    @@Precio_libertad = 200
    @@Saldo_inicial = 7500
    
    def initialize(encarcelado = false , nombre = "Undefined", num_casilla_actual = 0, puede_comprar = true, saldo = @@Saldo_inicial, propiedades = Array.new, salvoconducto = nil )
          
        @encarcelado = encarcelado
        @nombre = nombre
        @num_casilla_actual = num_casilla_actual
        @puede_comprar = puede_comprar
        @saldo = saldo
        @propiedades = propiedades
        @salvoconducto = salvoconducto   
        
    end
   
    attr_reader :encarcelado, :num_casilla_actual, :puede_comprar, :salvoconducto, :Casas_por_hotel

    attr_reader :nombre, :propiedades, :saldo
 
    
    private
    
    attr_reader :Casas_max, :Hoteles_max, :Precio_libertad, :Paso_por_salida
    private :Casas_max, :Hoteles_max, :Precio_libertad, :Paso_por_salida
    
    public
    
    def self.jugador1(nombre)
      self.new(false, nombre, 0, true, @@Saldo_inicial, nil, nil)
    end
    protected
    def self.jugador2(jugador)    
      self.new(jugador.encarcelado, jugador.nombre, jugador.num_casilla_actual, jugador.puede_comprar, jugador.saldo, jugador.propiedades, jugador.salvoconducto)   
    end
      
    def debe_ser_encarcelado
        
      if !@encarcelado
        if @salvoconducto == nil      
          return true  
        else
        perder_salvoconducto
        Diario.instance.ocurre_evento("El jugador #{@nombre} se libra de la carcel y pierde salvoconducto.")
        return false  
        end
      else
        return false
      end
      
    end
    
    public
    
    def encarcelar(num_casilla_carcel)
      if debe_ser_encarcelado        
        mover_a_casilla(num_casilla_carcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido trasladado a la carcel.")   
      end
      return @encarcelado
    end
    
    def obtener_salvoconducto(sorpresa)
      
      if !encarcelado
        @salvoconducto = sorpresa
        return true
      else
        return false
      end
   
    end
    
    private
    
    def perder_salvoconducto
      
      @salvoconducto.usada
      @salvoconducto = nil
      
    end
    
    public
    
    def tiene_salvoconducto
      
      return @salvoconducto != nil
      
    end
    
    def puede_comprar_casilla
      @puede_comprar = true
      if @encarcelado
        @puede_comprar = false
      end
      
      return @puede_comprar
      
    end
    
    def paga(cantidad)
      
      return modificar_saldo(cantidad*-1)
      
    end
    
    def paga_impuesto(cantidad)
      if @encarcelado
        return false
      else
        return paga(cantidad)
      end
    end
    
    def paga_alquiler(cantidad)
      if @encarcelado
        return false
      else
        return paga(cantidad)
      end
    end
    
    def recibe(cantidad)
      if @encarcelado
        return false
      else
        return modificar_saldo(cantidad)
      end
    end
      
    def modificar_saldo(cantidad)
      @saldo += cantidad
      Diario.instance.ocurre_evento("El saldo del jugador #{@nombre} ha sido modificado a #{@saldo}")
      return true
    end
    
    def mover_a_casilla(num_casilla)
      
      if !@encarcelado
        @num_casilla_actual = num_casilla
        @puede_comprar = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido movido a la casilla #{@num_casilla_actual}");
        return true
      else
        return false
      end    
      
    end
    
    private
    
    def puedo_gastar(precio)     
      if !@encarcelado
            return @saldo >= precio;
      else
            return false;
      end
    end
    
    public
    
    def vender(ip)
      
      if !@encarcelado && existe_la_propiedad(ip)
        vender = @propiedades[ip].vender(self)
        
        if vender
          @propiedades.delete(ip)
          Diario.instance.ocurre_evento("El jugador #{@nombre} ha vendido la propiedad #{@propiedades[ip].nombre}")
          return true
        end
      end
      
      return false
      
    end
    
    def tiene_algo_que_gestionar
      
      algo = false
      
      if (@propiedades.size) > 0 #eee
        algo = true
      end
      
      return algo
      
    end
    
    private
    
    def puede_salir_carcel_pagando      
      return @saldo >= @@Precio_libertad   
    end
    
    public
    
    def salir_carcel_pagando
      
      val = false 
      
      if @encarcelado and puede_salir_carcel_pagando
        paga(@@Precio_libertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel pagando");
      
      end
      
      return val
      
    end
    
    def salir_carcel_tirando
      
      val = false
      
      if Dado.instance.salgo_de_la_carcel
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel tirando")
        
      end
      
      return val
      
    end
    
    def pasa_por_salida
      @modifica = modificar_saldo(@@Paso_por_salida)
      Diario.instance.ocurre_evento("El jugador #{@nombre} pasa por salida y cobra 100")
      return @modifica
    end
    
    def cantidad_casas_hoteles
      
      suma = 0
      
      for i in (0..@propiedades.size - 1)
        suma += propiedades[i].cantidad_casas_hoteles
      end
      
      return suma
      
    end
    
    def en_bancarrota
      
      if(@saldo <0)
        return true
      else
        return false
      end
      
    end
    
    private
    
    def existe_la_propiedad(ip)
      return ip >= 0 && ip < @propiedades.size
    end
    
    public
    
    def is_encarcelado
      return @encarcelado
    end
    
    private
    
    def puedo_edificar_casa(propiedad)

        precio = propiedad.precio_edificar()

      return propiedad.es_este_el_propietario(self) && propiedad.num_casas() < @@Hoteles_max && self.puedo_gastar(precio)

    end

    def puedo_edificar_hotel(propiedad)

        precio = propiedad.precio_edificar()

      return propiedad.num_casas >=  @@Casas_por_hotel && propiedad.num_hoteles() < @@Hoteles_max && self.puedo_gastar(precio)

    end
    
    public
    
    def <=>(jugador)
      
      if @saldo > jugador.saldo
        return 1
      elsif @saldo == jugador.saldo
        return 0
      else
        return -1
      end
      
    end

    def to_s 
      
      
      return "Nombre del jugador: #{@nombre} 
              Saldo del jugador: #{@saldo}
              Numero de propiedades del jugador: #{@propiedades}
              Numero de casilla actual del jugador: #{@num_casilla_actual}"
    end
   
    
    def construir_casa(ip)
        result =false 
        puedo_edificar_casa =false
        
        if(@encarcelado)
            return result
        else
            
            existe = existe_la_propiedad(ip)
        
            if(existe)
                
                propiedad = @propiedades.get(ip)
                puedo_edificar_casa=puedo_edificar_casa(propiedad)
                precio = propiedad.get_precio_edificar
                if(puedo_gastar(precio) && propiedad.get_num_casas <get_casas_max)
                    
                    puedo_edificar_casa=true
                    
                end
                if(puedo_edificar_casa)
                    
                    result=propiedad.construir_asa(self)
                    
                    if(result)
                        
                        Diario.instance.ocurre_evento("El jugador #{@nombre} construye casa en la propiedad #{@propiedades.get()}")
                        
                    end
                end
            end
        end
        
        return result
    end
    
    def construir_hotel(ip)
        result = false
        
        if(@encarcelado)
            return result
        end
        
        if existe_la_propiedad(ip)
            
          propiedad = @propiedades.get(ip)
            
          puedo_edificar_hotel = puedo_edificar_hotel(propiedad)
   
          if(puedo_edificar_hotel)
                
          result = propiedad.construir_hotel(self)
          propiedad.derruir_casas(@@Casas_por_hotel, self)
                
          end
          
          Diario.getInstance().ocurreEvento("El jugador #{@nombre} costruye hotel en la propiedad #{ip}")
          
          end
        
          return result
            
    end
    
    def hipotecar(ip)
        
        result=false
        if @encarcelado
            
            return result
            
        end
        
        if existe_la_propiedad(ip)
            
            propiedad = TituloPropiedad.new(@propiedades.get(ip).nombre,@propiedades.get(ip).alquiler_base,@propiedades.get(ip).factor_revalorizacion,@propiedades.get(ip).precio_hipoteca_base,@propiedades.get(ip).precio_compra,@propiedades.get(ip).precio_edificar) 
            result=propiedad.hipotecar(self)
                     
        end
        if result
            
            Diario.instance.ocurre_evento("El jugador #{@nombre} hipoteca la propiedad #{@propiedades.get(ip).nombre}") 
            
        end
        
        return result
    end
      
    def cancelar_hipoteca(ip)
    
        result=false
        
        if @encarcelado
            
            return result
            
        end
        if(existe_la_propiedad(ip))
            
            propiedad = TituloPropiedad.new(@propiedades.get(ip).nombre,@propiedades.get(ip).alquiler_base,@propiedades.get(ip).factor_revalorizacion,@propiedades.get(ip).precio_hipoteca_base,@propiedades.get(ip).precio_compra,@propiedades.get(ip).precio_edificar)
            cantidad = propiedad.get_importe_cancelar_hipoteca
            puedo_gastar=puedo_gastar(cantidad)
            if puedo_gastar
                
                result = propiedad.cancelar_hipoteca(self)
                                
            end
            if result
                    
              Diario.instance.ocurre_evento("El jugador #{@nombre} deshipoteca la propiedad #{@propiedades.at(ip).nombre}") 
              
            end
        end
        
        
        return result
    
    end
    
    
  end
    
    
end
