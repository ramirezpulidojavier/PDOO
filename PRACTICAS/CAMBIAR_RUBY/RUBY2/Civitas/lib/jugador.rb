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
    
    def cancelar_hipoteca(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if(existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        cantidad = propiedad.hipoteca_base
        puedo_gastar = puedo_gastar(cantidad)
        if (puedo_gastar)
          result = propiedad.cancelar_hipoteca(self)
          if (result)
            Diario.instance.ocurre_evento("El jugador #{@nombre} cancela la hipoteca de la propiedad #{propiedad.nombre}");
            puts Diario.instance.leer_evento
          end
        end
      end
    end
    public
    def tiene_salvoconducto
      
      if @salvoconducto == nil
            return false
        else
            return true
        end
      
    end
    def cantidad_casas_hoteles
      suma = 0
      
      for i in (0..@propiedades.size - 1)
        suma += @propiedades[i].cantidad_casas_hoteles
      end
      
      return suma
    end
    
    def compare_to(otro)
      return this.saldo<=>otro.saldo
    end
    
    def comprar(titulo)
      result = false
      if (@encarcelado)
        return result
      end
      if(@puede_comprar)
        precio = titulo.precio_compra
        if(puedo_gastar(precio))
          result = titulo.comprar(self)
          if (result)
            @propiedades.push(titulo)
            Diario.instance.ocurre_evento("El jugador #{@nombre} compra la propiedad #{titulo.to_s}")
          end
          @puede_comprar = false
        end
      end
      return result
    end
    
    def construir_imperio()
        
        result =false
        
        if(@encarcelado)
            return result
        else
            
            cont=0
            
            while(cont<@propiedades.size())
                @saldo = @saldo*2
                propiedad=@propiedades[cont]
                result=propiedad.construir_imperio(self)
                if(propiedad.hipotecado)
                    propiedad.cancelarHipoteca(self)
                while ((propiedad.num_hoteles + propiedad.num_casas) < 8 && @saldo>= @propiedades[cont].precio_edificar) 
                
                    if(propiedad.num_casas<4)
                        
                        construir_casa(cont)
                        
                    else
                    
                        construir_hotel(cont)
                        propiedad.derruir_casas(4, self)
                    end
                    
                end
                
                cont += 1
                    
                end
            end
        
        
        return result
        
    end
    
    end
    
    def construir_casa(ip)
      result = false
      puedo_edificar_casa = false
      if (@encarcelado)
        return result
      else
        existe = existe_la_propiedad(ip)
        if (existe)
          propiedad = @propiedades[ip]
          puedo_edificar_casa = puedo_edificar_casa(propiedad)
          if(puedo_edificar_casa)
            result = propiedad.construir_casa(self)
          end
        end
      end
    end
    
    def construir_hotel(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if (existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        puedo_edificar_hotel = puedo_edificar_hotel(propiedad)
        precio = propiedad.precio_edificar
        if (puedo_gastar(precio) && propiedad.num_hoteles < @@Hoteles_max && propiedad.num_casas < @@Casas_por_hotel)
          puedo_edificar_hotel = true;
        end
        if (puedo_edificar_hotel)
          result = propiedad.construir_hotel(self)
          propiedad.derruir_casas(@@Casas_por_hotel, self)
          Diario.instance.ocurre_evento("El jugador #{@nombre} contruye hotel en la propiedad #{propiedad.nombre}")
          puts Diario.instance.leer_evento
        end
      end
      return result
    end
    
    def debe_ser_encarcelado
      if (@encarcelado)
        return false
      else
        if (!@tiene_salvaconducto)
          return true
        else
          perder_salvoconducto
          Diario.instance.ocurre_evento("Pierde salvoconducto")
          puts Diario.instance.leer_evento
          return false
        end
      end
    end
    public
    def en_bancarrota
      return @saldo < 0
    end
    
    def encarcelar (numCasillaCarcel)
      if (debe_ser_encarcelado)
        mover_a_casilla(numCasillaCarcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("#{@nombre} encarcelado.")
        puts Diario.instance.leer_evento
        return true
      else
        return false
      end
    end
    
    def existe_la_propiedad(ip)
      return @propiedades[ip] != nil
    end
    
    def hipotecar(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if (existe_la_propiedad(ip))
        propiedad = @propiedades[ip]
        result = propiedad.hipotecar(self)
      end
      
      if (result)
        Diario.instance.ocurre_evento("El jugador #{@nombre} hipoteca la propiedad #{propiedad.nombre}")
        puts Diario.instance.leer_evento
      end
      
      return result
    end
    
    def modificar_saldo(cantidad)
      @saldo = @saldo + cantidad.to_i
      Diario.instance.ocurre_evento("El saldo del jugador #{@nombre} ha sido modificado a #{@saldo}")
      return true
    end
    
    def mover_a_casilla(numCasilla)
      if (@encarcelado)
        return false
      else
        @num_casilla_actual = numCasilla
        #@puedeComprar = false
        Diario.instance.ocurre_evento("#{@nombre} movido a la casilla: #{@num_casilla_actual}")
        puts Diario.instance.leer_evento
        return true
      end
    end
    public
    def obtener_salvoconducto(s)
      if (@encarcelado)
        return false
      else
        @salvaconducto = s
        return true
      end
    end
    
    def paga(cantidad)
      return modificar_saldo(-cantidad)
    end
    
    def paga_alquiler(cantidad)
      if (@encarcelado)
        return false
      else
        puts "#{@nombre} paga #{cantidad} de impuesto."
        return paga(cantidad)
      end
    end
    
    def paga_impuesto(cantidad)
      return paga_alquiler (cantidad)   #de momento
    end
    
    def pasa_por_salida
      @saldo += @@Paso_por_salida
      Diario.instance.ocurre_evento("#{@nombre} pasa por salida, cobra: #{@@Paso_por_salida}.")
      puts Diario.instance.leer_evento
      return true
    end
    
    def perder_salvoconducto
      @salvaconducto.usada
      @salvaconducto = nil
      @tiene_salvaconducto = false
    end
    
    def puede_comprar_casilla
      return !@encarcelado
    end
    
    def puede_salir_carcel_pagando
      return @saldo >= @@Precio_libertad
    end
    
    def puedo_edificar_casa(propiedad)
      poseedor = false
      for i in (0..(@propiedades.length-1))
        if(@propiedades[i] == propiedad)
          poseedor = true
        end
      end
      return (poseedor and @saldo >= propiedad.precio_edificar)
    end
    
    def puedo_edificar_hotel(propiedad)
      poseedor = false
      for i in (0..(@propiedades.length-1))
        if(@propiedades[i] == propiedad)
          poseedor = true
        end
      end
      return (poseedor and @saldo >= (5-propiedad.num_casas) * propiedad.precio_edificar)
    end
    
    def puedo_gastar(precio)
      if (@encarcelado)
        return false
      else
        return @saldo >= precio
      end
    end
    
    def recibe(cantidad)
      if (@encarcelado)
        return false
      else
        return modificar_saldo(cantidad)
      end
    end
    
    def salir_carcel_pagando
      if (@encarcelado and puede_salir_carcel_pagando)
        paga(@@Precio_libertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("#{@nombre} paga #{@@Precio_libertad} para salir de la carcel.")
        puts Diario.instance.leer_evento
        return true
      else
        return false
      end
    end
    
    def salir_carcel_tirando
      if (Dado.instance.salgo_de_la_carcel)
        @encarcelado = false
        Diario.instance.ocurre_evento("#{@nombre} sale de la carcel tirando.")
        puts Diario.instance.leer_evento
        return true
      else
        Diario.instance.ocurre_evento("#{@nombre} NO sale de la carcel tirando.")
        puts Diario.instance.leer_evento
        return false
      end
    end
    
    def tiene_algo_que_gestionar
      return @propiedades.length > 0
    end
    
    def to_s
      return "nombre: #{@nombre} - saldo: #{@saldo} - casilla actual: #{@num_casilla_actual} - encarcelado: #{@encarcelado} - tiene salvoconducto: #{@tiene_salvoconducto} - cantidad propiedades: #{@propiedades.length}."
    end
    
    def vender (ip)
      if (!@encarcelado and existe_la_propiedad(ip))
        Diario.instance.ocurre_evento("#{@nombre} vende: #{@propiedades[ip].to_s}")
        puts Diario.instance.leer_evento
        recibe(@propiedades[ip].get_precio_venta)
        @propiedades[ip].vender(self)
        @propiedades.pop(ip)
        return true
      else
        return false
      end
    end
    
    public :compare_to, :to_s
    protected :debe_ser_encarcelado
  end
end