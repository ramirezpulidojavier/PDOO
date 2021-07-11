# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas

  class Jugador
    
    @@casas_max = 4
    @@casas_por_hotel = 4
    @@hoteles_max = 4
    @@paso_por_salida = 100
    @@precio_libertad = 200
    @@saldo_inicial = 7500
    
    def initialize(encarcelado = nil, nombre = nil, num_casilla_actual = 0, puede_comprar = false, saldo = @@saldo_inicial, propiedades = [], salvoconducto = nil )
          
        @encarcelado = encarcelado
        @nombre = nombre
        @num_casilla_actual = num_casilla_actual
        @puede_comprar = puede_comprar
        @saldo = saldo
        @propiedades = propiedades
        @salvoconducto = salvoconducto   
        
    end
   
    attr_reader :encarcelado, :num_casilla_actual, :puede_comprar, :salvoconducto, :casas_por_hotel
    
    protected
    attr_reader :nombre, :propiedades, :saldo
    
    private
    
    attr_reader :casas_max, :hoteles_max, :precio_libertad, :paso_por_salida
    
    protected
    
    def self.jugador(jugador)    
      new(jugador.encarcelado, jugador.nombre, jugador.num_casilla_actual, jugador.puede_comprar, jugador.saldo, jugador.propiedades, jugador.salvoconducto)   
    end
    
    
      
    def debe_ser_encarcelado
        
      if !@encarcelado && @salvoconducto == nil         
        return true         
      else
        perder_salvoconducto
        Diario.instance.ocurre_evento("El jugador #{@nombre} se libra de la carcel.")
        return false          
      end
      
    end
    
    public
    
    def encarcelar(num_casilla_carcel)
      if debe_ser_encarcelado        
        mover_a_casilla(num_casilla_carcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido trasladado a la carcel.")
        return @encarcelado     
      end
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
      
      if @encarcelado
        @puede_comprar = false
      else
        @puede_comprar = true
      end
      
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
      Diario.instance.ocurreEvento("El saldo del jugador #{@nombre} ha sido modificado a #{@saldo}")
      return true
    end
    
    def mover_a_casilla(num_casilla)
      
      if !@encarcelado
        @num_casilla_actual = num_casilla
        @puedo_comprar = false
        Diario.instance.ocurreEvento("El jugador #{@nombre} ha sido movido a la casilla #{@num_casilla_actual}");
        return true
      else
        return false
      end    
      
    end
    
    private
    
    def puedo_gastar(precio)     
      return @saldo >= precio
    end
    
    public
    
    def vender(ip)
      
      if !@encarcelado && existe_la_propiedad(ip)
        vender = propiedades[ip].vender(self)
        
        if vender
          propiedades.delete(ip)
          Diario.instance.ocurre_evento("El jugador #{@nombre} ha vendido la propiedad #{@propiedades[ip].nombre}")
          return true
        end
      end
      
      return false
      
    end
    
    def tiene_algo_que_gestionar
      if @propiedades != null
        return true
      else
        return false
      end
    end
    
    def puede_salir_carcel_pagando
      
      if @saldo >= @precio_libertad
        return true
     
      else
        return false
      
      end
    end
    
    def salir_carcel_pagando
      if @encarcelado && puede_salir_carcel_pagando
        paga(@precio_libertad)
        @encarcelado = false
        Diario.instance.ocurreEvento("El jugador #{@nombre} sale de la carcel pagando");
        return true
      else
        return false
      end
    end
    
    def salir_carcel_tirando
      if Dado.instance.salgo_de_la_carcel
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel")
        return true
      else
        return false
      end
    end
    
    def pasa_por_salida
      @modifica = modificar_saldo(paso_por_salida)
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
      return @saldo < 0
    end
    
    def existe_la_propiedad(ip)
      return ip >= 0 && ip < @propiedades.size
    end
    
    def puedo_edificar_casa(propiedad)
      return true
    end
    
    def puedo_edificar_hotel(propiedad)
      return true
    end
    
    /*
      def cancelar_hipoteca(ip)
      
      end

      def comprar(titulo)

      end

      def construir_casa(ip)

      end

      def construir_hotel(ip)

      end

      def hipotecar(ip)

      end
    
    */
      
    def to_string(ip)       
      return "Jugador de nombre #{@nombre} situado en la casilla #{@num_casilla_actual} con saldo #{@saldo}";
    end
    
    
  end
    
    
end
