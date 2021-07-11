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
    @@Paso_por_salida = 100
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
   
    attr_reader :encarcelado, :num_casilla_actual, :puede_comprar, :salvoconducto, :Casas_por_hotel, :nombre, :propiedades, :saldo
 
    private
    attr_reader :Casas_max, :Hoteles_max, :Precio_libertad, :Paso_por_salida
    private :Casas_max, :Hoteles_max, :Precio_libertad, :Paso_por_salida
    
    public
    def self.jugador1(nombre)
      self.new(false, nombre, 0, true, @@Saldo_inicial, Array.new, nil)
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
      else
        Diario.instance.ocurre_evento("El jugador #{@nombre} no ha sido trasladado a la carcel.")
      end
      return @encarcelado
    end
    
    def obtener_salvoconducto(sorpresa)
      
      if !@encarcelado
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
      @puede_comprar = !@encarcelado
      return @puede_comprar
      
    end
    
    def paga(cantidad)
      
      return modificar_saldo(cantidad*(-1))
      
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
        Diario.instance.ocurre_evento("El jugador #{@nombre} no ha sido movido a la casilla #{@num_casilla_actual}");
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
          Diario.instance.ocurre_evento("El jugador #{@nombre} ha vendido la propiedad #{@propiedades[ip].nombre}")
          @propiedades.delete(ip)
          return true
        end
      end
      Diario.instance.ocurre_evento("El jugador #{@nombre} no ha vendido la propiedad #{@propiedades[ip].nombre}")
      return false
      
    end
    
    def tiene_algo_que_gestionar
      
      return @propiedades != nil
      
    end
    
    def puede_salir_carcel_pagando      
      return @saldo >= @@Precio_libertad   
    end
    
    
    def salir_carcel_pagando
      
      if @encarcelado and puede_salir_carcel_pagando
        paga(@@Precio_libertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel pagando\n");
        return true
      end
      Diario.instance.ocurre_evento("El jugador #{@nombre} no sale de la carcel pagando porque no tiene dinero\n");
      return false
      
    end
    
    def salir_carcel_tirando
      if Dado.instance.salgo_de_la_carcel
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel tirando")
        return true
      end
      Diario.instance.ocurre_evento("El jugador #{@nombre} ha tirado pero no sale de la carcel ")
      return false
      
    end
    
    def pasa_por_salida
      modificar_saldo(@@Paso_por_salida)
      Diario.instance.ocurre_evento("El jugador #{@nombre} pasa por salida y cobra 100")
      return true
    end
    
    def cantidad_casas_hoteles
      
      suma = 0
      
      for i in (0..@propiedades.size - 1)
        suma += @propiedades[i].cantidad_casas_hoteles
      end
      
      return suma
      
    end
    
    def en_bancarrota
      
      return @saldo<0;
      
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

      return propiedad.es_este_el_propietario(self) && propiedad.num_casas() < @@Casas_por_hotel && self.puedo_gastar(precio)

    end

    def puedo_edificar_hotel(propiedad)

        precio = propiedad.precio_edificar()

      return propiedad.num_casas ==  @@Casas_por_hotel && propiedad.num_hoteles < @@Casas_por_hotel && self.puedo_gastar(precio)

    end
    
    def cancelar_hipoteca(ip)
    
        result=false
        
        if @encarcelado
            
            return result
            
        end
        if(existe_la_propiedad(ip))
            
            propiedad = @propiedades.at(ip)
            cantidad = propiedad.get_importe_cancelar_hipoteca
            puedo_gastar=puedo_gastar(cantidad)
            if puedo_gastar
                
                result = propiedad.cancelar_hipoteca(self)
                if result
                  Diario.instance.ocurre_evento("El jugador #{@nombre} deshipoteca la propiedad #{@propiedades.at(ip).nombre}") 
                else
                  Diario.instance.ocurre_evento("El jugador #{@nombre} no puede cancelar la hipoteca de la propiedad #{@propiedades.at(ip).nombre}")
                end  
            else
              Diario.instance.ocurre_evento("El jugador #{@nombre} no puede cancelar la hipoteca de la propiedad #{@propiedades.at(ip).nombre}")
            end
            
        end
        
        
        return result
    
    end
    def comprar(titulo)
           
           result = false

        if (@encarcelado)
            return result
        end
        if (@puede_comprar)

            precio = titulo.get_precio_compra

            if (puedo_gastar(precio))
                
                result = titulo.comprar(self)

                if (result)
                    @propiedades << titulo
                    Diario.instance.ocurre_evento("El jugador #{@nombre} compra " + titulo.to_s);
                end
          end
        end

        return result;
           
           
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
          casas_por_hotel=@@Casas_por_hotel
          propiedad.derruir_casas(casas_por_hotel, self)
          Diario.getInstance().ocurreEvento("El jugador #{@nombre} costruye hotel en la propiedad #{ip}")     
          else
            Diario.getInstance().ocurreEvento("El jugador #{@nombre} no costruye hotel en la propiedad #{ip} porque no tiene 4 casas construidas o no tiene dinero.\n")    
          end
          
          
          
          end
        
          return result
            
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
                if(puedo_gastar(precio) && propiedad.num_casas <@@Casas_max)
                    
                    puedo_edificar_casa=true
                    
                end
                if(puedo_edificar_casa)
                    
                    result=propiedad.construir_casa(self)
                    
                    if(result)
                        
                        Diario.instance.ocurre_evento("El jugador #{@nombre} construye casa en la propiedad #{@propiedades.get(ip)}")
                    else
                        Diario.instance.ocurre_evento("El jugador #{@nombre} no puede construir casa en la propiedad (porque ya tiene 4 o no tiene money)#{@propiedades.get(ip)}")
                    end
                else
                  Diario.instance.ocurre_evento("El jugador #{@nombre} no puede construir casa en la propiedad (porque ya tiene 4 o no tiene money)#{@propiedades.get(ip)}")
                end
            end
        end
        
        return result
    end
    
    def hipotecar(ip)
        
        result=false
        if @encarcelado
            
            return result
            
        end
        
        if existe_la_propiedad(ip)
            
            result=@propiedades.get(ip).hipotecar(self);
                     
        end
        if result
            
            Diario.instance.ocurre_evento("El jugador #{@nombre} hipoteca la propiedad #{@propiedades.get(ip).nombre}") 
        else
          Diario.instance.ocurre_evento("El jugador #{@nombre} no puede hipotecar la propiedad #{@propiedades.get(ip).nombre}") 
        end
        
        return result
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
      
      
      return "Jugador de nombre: #{@nombre} 
              situado en: #{@num_casilla_actual}
              con saldo: #{@saldo}"
    end
    
    
      
    
    
    
  end
    
    
end
