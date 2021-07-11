# encoding: utf-8


module Civitas
  class Jugador
    
    attr_accessor :nombre, :num_casilla_actual,:propiedades,:saldo, :puede_comprar, :encarcelado, :salvoconducto
    
      @@casas_max = 4
      @@casas_por_hotel = 4
      @@hoteles_max = 4
      @@paso_por_salida = 1000
      @@precio_por_libertad = 200
      @@saldo_inicial = 7500
    
    
    def initialize(n)
      
      @encarcelado = false
      @nombre=n
      @num_casilla_actual=1
      @propiedades = Array.new
      @puede_comprar=true
      @saldo=@@saldo_inicial
      @salvoconducto=nil
      
      
    end
    
     #constructor por copia
    
    def copia(otro)
  
      @encarcelado = otro.encarcelado
      @nombre = otro.nombre
      @num_casilla_actual = otro.num_casilla_actual
      @propiedades = otro.propiedades
      @puede_comprar = otro.puede_comprar
      @saldo = otro.saldo
      @salvoconducto = otro.salvoconducto
      
    end
    
    
    #Override
    def to_s      
      return self.class.name + " de nombre " + @nombre + " con saldo " + @saldo.to_s + " situado en la casilla " + @num_casilla_actual.to_s 
    end
    
    def self.casas_max
      @@casas_max
    end
    
    def self.casas_por_hotel
      @@casas_por_hotel
    end
    
    def self.hoteles_max
      @@hoteles_max
    end
    
    def self.paso_por_salida
      @@paso_por_salida
    end
    
    def self.precio_por_libertad
      @@precio_por_libertad
    end
    
    def self.premio_paso_salida
      @@paso_por_salida
    end
    
    
    
    
   
    
    #Devuelve si debe ser encarcelado o no. se puede librar con carta sorpresa
    def debe_ser_encarcelado
      if @encarcelado
        return false
      else
         if tiene_salvoconducto
           perder_salvoconducto()
           Diario.instance.ocurre_evento("El jugador #{@nombre} no debe ser encarcelado")
           return false
         else
           return true
         end
      end
    end
    
    #metodo para encarcelar a un jugador
    def encarcelar(num_casilla_carcel)
      if debe_ser_encarcelado
        mover_a_casilla(num_casilla_carcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido encarcelado")
      end
      return @encarcelado
    end
    
    #se guarda en el atributo salvoconducto el parametro s
    def obtener_salvoconducto(s)
      if encarcelado
        return false
      else
        @salvoconducto = s
      end   
    end
    
    #se pone salvoconducto a null tras ser usada
    
    def perder_salvoconducto()
      @salvoconducto.usada()
      @salvoconducto = nil
    end
    
    #existe propiedad
    def existe_la_propiedad (ip)
       return (ip >= 0 && ip < @propiedades.size() );
      
    end
    
    # Muestra si tiene salvoconducto o no
    
    def tiene_salvoconducto
      if @salvoconducto == nil
        return false
      else
        return true
      end  
    end
    
    
    #Muestra si puede comprar o no
    def puede_comprar_casilla
      @puede_comprar = true
      
      if @encarcelado
        @puede_comprar = false
      end
      return @puede_comprar
    end
    
    
    #Modifica el saldo tras pagar
    def paga(cantidad)
      
      return modificar_saldo(cantidad *-1)
    end
    
    
    #Paga impuesto si no está encarcelado
    def paga_impuesto(cantidad)
      if @encarcelado
        return false
      else 
        paga(cantidad)   
      end 
    end
    
    #Si no esta encarcelado para el alquiler
    def paga_alquiler(cantidad)
        if @encarcelado
        return false
      else 
        paga(cantidad)   
      end  
    end
    
    
    #Se suma la cantidad que recibe
    def recibe(cantidad)
      if @encarcelado
        return false
      else
        return modificar_saldo(cantidad)
      end
    end
    
    
    #Se le modifica el saldo al jugador
    def modificar_saldo(cantidad)
      @saldo += cantidad
      Diario.instance.ocurre_evento("\nEl saldo del jugador #{@nombre} ha sido modificado a #{@saldo}")
      return true
    end
    
    #se mueve un jugador
    def mover_a_casilla(numCasilla)
      if @encarcelado
        return false
      else
        @num_casilla_actual = numCasilla
        @puede_comprar = false
        Diario.instance.ocurre_evento("\nEl jugador #{@nombre} se ha movido de casilla #{@num_casilla_actual}")
        return true
      end
    end
    
    #Muestra si el saldo es mayor que el precio a gastar
    def puedo_gastar(precio)
      if @encarcelado
        return false
      else
        return @saldo >= precio
      end 
    end
    
    
    
    def vender(ip)
      if @encarcelado
        return false
      else
        if existe_la_propiedad(ip) && @propiedades[ip].vender(self)
            Diario.instance.ocurre_evento("\nEl jugador #{@nombre} ha vendido la propiedad #{@propiedades.at(ip).nombre}")
            @propiedades.delete_at(ip)
            return true
        end
        return false
      end
    end
    
    
    #Muestra si el jugador tiene propiedades
    def tiene_algo_que_gestionar
      
      return @propiedades.size >= 1
    end
    
    #Muestra si puede pagar para salir de la carcel
    def puede_salir_carcel_pagando
      
      return @saldo > @@precio_por_libertad
    end
    
    def salir_carcel_pagando
      result = false
      if(puede_salir_carcel_pagando && @encarcelado)
        paga(@@precio_por_libertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("\nEl jugador #{@nombre} paga para salir de la carcel")
        result = true
      end
      return result
    end
    
    #Muestra si sale de la carcel tirando
    def salir_carcel_tirando
      if Dado.instance.salgo_de_la_carcel
        @encarcelado = false
        Diario.instance.ocurre_evento("\nEl jugador #{@nombre} logra salir de la carcel tirando")
        return true
      else
        return false
      end  
    end
    
    #Se realiza el pago de paso por salida
    
    def pasa_por_salida
      
      modificar_saldo(@@paso_por_salida)
      Diario.instance.ocurre_evento("\nEl jugador #{@nombre} cobro el paso por salida")
      return true
    end
    
    
    def compare_to(otro)
      
      return @saldo < otro.saldo
    end
    
    def en_bancarrota
      
      return if @saldo == 0;
    end
    
    
    def cancelar_hipoteca(ip)
      
      result = false
      if(@encarcelado)
        return result
      end
      
      if(existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        cantidad = propiedad.get_importe_cancelar_hipoteca
        puedo_gastar= puedo_gastar(cantidad)
        
        if(puedo_gastar)
          result = propiedad.cancelar_hipoteca(self)
        end
      end
      
      if(result)
        Diario.instance.ocurre_evento("\nEl jugador "+@nombre.to_s+" cancela la hipoteca de la propiedad "+ip.to_s)
      end
      
      return result
      
    end
    
    def cantidad_casas_hoteles
      
      contador=0
      
      for i in 0...@propiedades.size()
        contador = contador + @propiedades[i].num_casas
        contador = contador + @propiedades[i].num_hoteles
      end
      
      return contador
    end
    
    def comprar(titulo)
      result = false
      
      if(@encarcelado)
        return result
      end
      
      if(@puede_comprar)
        precio=titulo.precio_compra
   
        if(puedo_gastar(precio))
          propiedades.push(titulo)
          result = titulo.comprar(self)
        end
      end
      
      if(result)
        Diario.instance.ocurre_evento("\nEl jugador "+self.nombre+" compra la propiedad #{titulo.nombre}")
      end
      
      return result
    end
    
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
          
          #if(ip.num_casas < @@casas_max && puedo_gastar(ip.precio_edificar))
          #  puedo_edificar_casa = true
          #end
  
          if(puedo_edificar)
            result = propiedad.construir_casa(self)
            if result
              Diario.instance.ocurre_evento("\nEl jugador " +nombre+ " construye casa en la propiedad "+ @propiedades[ip].nombre);              
            else
              Diario.instance.ocurre_evento("\nEl jugador " +nombre+ " no construye casa en la propiedad "+ @propiedades[ip].nombre + "porque no tiene dinero o tiene el maximo numero de casas");
          
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
      
      if(existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        puedo_edificar_hotel = puedo_edificar_hotel(propiedad)
        precio = propiedad.precio_edificar
        
        if(puedo_gastar(precio) && propiedad.num_hoteles < @@hoteles_max && propiedad.num_casas >= @@casas_por_hotel)
          puedo_edificar_hotel = true
        end
        
        if(puedo_edificar_hotel)
          result = propiedad.construir_hotel(self)
          
          casas_por_hotel = @@casas_por_hotel
          propiedad.derruir_casas(casas_por_hotel, self)
          puts "Construyo hotel y mi saldo ahora es #{@saldo}"
          Diario.instance.ocurre_evento("El jugador "+@nombre.to_s+" construye hotel en la propiedad "+ip.to_s)
          
        else
          puts "No construyo hotel porque no hay 4 casas aun o porque no tengo dinero "
      
        end
      end
      return result
      
    end
    
    def hipotecar(ip)
      
      result = false
      if(@encarcelado)
        return result
      end
      
      if(existe_la_propiedad(ip) )
        propiedad = @propiedades[ip]
        result = propiedad.hipotecar(self)
        
      end
      
      if(result)
        Diario.instance.ocurre_evento("\nEl jugador "+@nombre.to_s+" hipoteca la propiedad "+ip.to_s)
      end
      
      
    end
    
    def puedo_edificar_casa(propiedad)
    
      if @propiedades.include?(propiedad) && @saldo >= propiedad.precio_edificar && propiedad.num_casas < 4
        return true
      else
        return false
      end  
    end
    
    def puedo_edificar_hotel(propiedad)
      
      if @propiedades.include?(propiedad) && @saldo >= propiedad.precio_edificar && propiedad.num_casas >= 4 && propiedad.num_hoteles < 4
        return true
      else
        return false
      end
    end
    
    def num_propiedades
      return @propiedades.size
    end
    
    
  
  end #end de class
end #end modulp
