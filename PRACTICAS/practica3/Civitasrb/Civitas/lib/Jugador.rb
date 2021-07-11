module Civitas
  class Jugador
    @@CasasMax = 4
    @@CasasPorHotel = 4
    @@HotelesMax = 4
    @@PasoPorSalida = 1000
    @@PrecioLibertad = 200
    @@SaldoInicial = 7500
    
    attr_accessor :nombre, :numCasillaActual, :saldo, :encarcelado, :puedeComprar, :salvoconducto, :tieneSalvoconducto, :propiedades
    
    def initialize(nombre)
      @nombre = nombre
      @numCasillaActual = 0
      @saldo = @@SaldoInicial
      @puedeComprar = true
      @encarcelado = false
      @salvoconducto = Sorpresa.new(TipoSorpresa::SALIRCARCEL, "SalirCarcel", 0, nil, nil)
      @tieneSalvoconducto = false
      @propiedades = Array.new
    end
    
    def self.newCopia(jugador)
      @nombre = jugador.nombre
      @encarcelado = jugador.encarcelado
      @numCasillaActual = jugador.numCasillaActual
      @puedeComprar = jugador.puedeComprar
      @saldo = jugador.saldo
      @tieneSalvoconducto = jugador.tieneSalvoconducto
      @salvoconducto = jugador.salvoconducto
      @propiedades = jugador.propiedades
    end
    
    def cancelarHipoteca(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if(existeLaPropiedad(ip))
        propiedad = @propiedades[ip]
        cantidad = propiedad.hipotecaBase
        puedoGastar = puedoGastar(cantidad)
        if (puedoGastar)
          result = propiedad.cancelarHipoteca(self)
          if (result)
            Diario.instance.ocurre_evento("El jugador #{nombre} cancela la hipoteca de la propiedad #{ip}");
            puts Diario.instance.leer_evento
          end
        end
      end
    end
    
    def cantidadCasasHoteles
      @suma = 0
      for i in (0..(@propiedades.length-1))
        @suma += @propiedades[i].cantidadCasasHoteles
      end
    end
    
    def compareTo(otro)
      return this.saldo<=>otro.saldo
    end
    
    def comprar(titulo)
      result = false
      if (@encarcelado)
        return result
      end
      if(@puedeComprar)
        precio = titulo.precioCompra
        if(puedoGastar(precio))
          result = titulo.comprar(self)
          if (result)
            @propiedades.push(titulo)
            Diario.instance.ocurre_evento("El jugador #{nombre} compra la propiedad #{titulo.toString}")
          end
          @puedeComprar = false
        end
      end
      return result
    end
    
    def construirCasa(ip)
      result = false
      puedoEdificarCasa = false
      if (@encarcelado)
        return result
      else
        existe = existeLaPropiedad(ip)
        if (existe)
          propiedad = @propiedades[ip]
          puedoEdificarCasa = puedoEdificarCasa(propiedad)
          if(puedoEdificarCasa)
            result = propiedad.construirCasa(self)
          end
        end
      end
    end
    
    def construirHotel(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if (existeLaPropiedad(ip))
        propiedad = @propiedades[ip]
        puedoEdificarHotel = puedoEdificarHotel(propiedad)
        precio = propiedad.precioEdificar
        if (puedoGastar(precio) && propiedad.numHoteles < @@HotelesMax && propiedad.numCasas < @@CasasPorHotel)
          puedoEdificarHotel = true;
        end
        if (puedoEdificarHotel)
          result = propiedad.construirHotel(self)
          propiedad.derruirCasas(@@CasasPorHotel, self)
          Diario.instance.ocurre_evento("El jugador #{nombre} contruye hotel en la propiedad #{ip}")
          puts Diario.instance.leer_evento
        end
      end
      return result
    end
    
    def debeSerEncarcelado
      if (@encarcelado)
        return false
      else
        if (!@tieneSalvaconducto)
          return true
        else
          perderSalvoconducto
          Diario.instance.ocurre_evento("Pierde salvoconducto")
          puts Diario.instance.leer_evento
          return false
        end
      end
    end
    
    def enBancarrota
      return @saldo < 0
    end
    
    def encarcelar (numCasillaCarcel)
      if (debeSerEncarcelado)
        moverACasilla(numCasillaCarcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("#{nombre} encarcelado.")
        puts Diario.instance.leer_evento
        return true
      else
        return false
      end
    end
    
    def existeLaPropiedad(ip)
      return @propiedades[ip] != nil
    end
    
    def hipotecar(ip)
      result = false
      if (@encarcelado)
        return result
      end
      
      if (existeLaPropiedad(ip))
        propiedad = @propiedades[ip]
        result = propiedad.hipotecar(self)
      end
      
      if (result)
        Diario.instance.ocurre_evento("El jugador #{nombre} hipoteca la propiedad #{ip}")
        puts Diario.instance.leer_evento
      end
      
      return result
    end
    
    def modificarSaldo (cantidad)
      @saldo += cantidad
      Diario.instance.ocurre_evento("#{nombre} aumenta su saldo: #{cantidad}")
      puts Diario.instance.leer_evento
      Diario.instance.ocurre_evento("Saldo restante: #{saldo}")
      puts Diario.instance.leer_evento
      return true
    end
    
    def moverACasilla(numCasilla)
      if (@encarcelado)
        return false
      else
        @numCasillaActual = numCasilla
        #@puedeComprar = false
        Diario.instance.ocurre_evento("#{nombre} movido a la casilla: #{numCasillaActual}")
        puts Diario.instance.leer_evento
        return true
      end
    end
    
    def obtenerSalvoconducto(s)
      if (@encarcelado)
        return false
      else
        @salvaconducto = s
        @tieneSalvaconducto = true
        return true
      end
    end
    
    def paga(cantidad)
      return modificarSaldo(-cantidad)
    end
    
    def pagaAlquiler(cantidad)
      if (@encarcelado)
        return false
      else
        puts "#{nombre} paga #{cantidad} de impuesto."
        return paga(cantidad)
      end
    end
    
    def pagaImpuesto(cantidad)
      return pagaAlquiler (cantidad)   #de momento
    end
    
    def pasaPorSalida
      @saldo += @@PasoPorSalida
      Diario.instance.ocurre_evento("#{nombre} pasa por salida, cobra: #{@@PasoPorSalida}.")
      puts Diario.instance.leer_evento
      return true
    end
    
    def perderSalvoconducto
      @salvaconducto.usada
      @salvaconducto = nil
      @tieneSalvaconducto = false
    end
    
    def puedeComprarCasilla
      return !@encarcelado
    end
    
    def puedeSalirCarcelPagando
      return @saldo >= @@PrecioLibertad
    end
    
    def puedoEdificarCasa(propiedad)
      @poseedor = false
      for i in (0..(@propiedades.length-1))
        if(@propiedades[i] == propiedad)
          @poseedor = true
        end
      end
      return (@poseedor and @saldo >= propiedad.precioEdificar)
    end
    
    def puedoEdificarHotel(propiedad)
      @poseedor = false
      for i in (0..(@propiedades.length-1))
        if(@propiedades[i] == propiedad)
          @poseedor = true
        end
      end
      return (@poseedor and @saldo >= (5-propiedad.numCasas) * propiedad.precioEdificar)
    end
    
    def puedoGastar(precio)
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
        return modificarSaldo(cantidad)
      end
    end
    
    def salirCarcelPagando
      if (@encarcelado and puedeSalirCarcelPagando)
        paga(@@PrecioLibertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("#{nombre} paga #{@@PrecioLibertad} para salir de la carcel.")
        puts Diario.instance.leer_evento
        return true
      else
        return false
      end
    end
    
    def salirCarcelTirando
      if (Dado.instance.salgoDeLaCarcel)
        @encarcelado = false
        Diario.instance.ocurre_evento("#{nombre} sale de la carcel tirando.")
        puts Diario.instance.leer_evento
        return true
      else
        Diario.instance.ocurre_evento("#{nombre} NO sale de la carcel tirando.")
        puts Diario.instance.leer_evento
        return false
      end
    end
    
    def tieneAlgoQueGestionar
      return @propiedades.length > 0
    end
    
    def toString
      return "nombre: #{nombre} - saldo: #{saldo} - casilla actual: #{numCasillaActual} - encarcelado: #{encarcelado} - tiene salvoconducto: #{tieneSalvoconducto} - cantidad propiedades: #{propiedades.length}."
    end
    
    def vender (ip)
      if (!@encarcelado and existeLaPropiedad(ip))
        Diario.instance.ocurre_evento("#{nombre} vende: #{propiedades[ip].toString}")
        puts Diario.instance.leer_evento
        recibe(@propiedades[ip].getPrecioVenta)
        @propiedades[ip].vender(this)
        @propiedades.pop(ip)
        return true
      else
        return false
      end
    end
    
    public :compareTo, :toString
    protected :debeSerEncarcelado
  end
end