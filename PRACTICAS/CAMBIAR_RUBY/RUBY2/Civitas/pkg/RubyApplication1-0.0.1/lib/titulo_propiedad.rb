module Civitas
  class TituloPropiedad
    @@factorInteresesHipoteca = 1.1
    public
    attr_accessor :nombre, :factorRevalorizado, :hipotecaBase, :precioCompra, :precioEdificar, :hipotecado, :tienePropietario, :propietario, :numCasas, :numHoteles, :alquilerBase
    def initialize (n, alq, f_r, h, c, p_e)
      @nombre = n
      @alquilerBase = alq
      @factorRevalorizado = f_r
      @hipotecaBase = h
      @precioCompra = c
      @precioEdificar = p_e
      @hipotecado = false
      @tienePropietario = false
      @propietario = Jugador.new("nadie")
      @numCasas = 0
      @numHoteles = 0
    end
    public
    def toString
      @estado = "nombre: #{nombre} - alquilerBase: #{alquilerBase} - factorRevalorizacion: #{factorRevalorizado} - hipotecaBase: #{hipotecaBase} - precioCompra: #{precioCompra} - precioEdificar: #{precioEdificar}"
      return @estado
    end
    public
    def getPrecioAlquiler
      if (@hipotecado or @propietario.encarcelado)
        return 0
      else
        return @alquilerBase + @alquilerBase*@numCasas + @alquilerBase*@numHoteles*5
      end
    end
    
    def esEsteElPropietario (jugador)
      return jugador == @propietario
    end
    
    def cancelarHipoteca (jugador)
      if (@hipotecado and esEsteElPropietario(jugador))
        jugador.paga(@hipotecaBase)
        return true
      else
        return false
      end
    end
    
    def hipotecar (jugador)
      if (!@hipotecado and esEsteElPropietario(jugador))
        jugador.recibe(@hipotecaBase)
        return true
      else
        return false
      end
    end
    
    def tramitarAlquiler (jugador)
      if (@tienePropietario and !esEsteElPropietario(jugador))
        jugador.paga(getPrecioAlquiler)
        @propietario.recibe(getPrecioAlquiler)
      end
    end
    
    def propietarioEncarcelado
      return @propietario.encarcelado
    end
    
    def cantidadCasasHoteles
      return @numCasas + @numHoteles
    end
    
    def derruirCasas (n, jugador)
      if (esEsteElPropietario(jugador) and @numCasas >= n)
        @numCasas -= n
        return true
      else
        return false
      end
    end
    
    def getPrecioVenta
      return @precioCompra + @numCasas * @factorRevalorizado + 5*@numHoteles * @factorRevalorizado
    end
    
    def construirCasa (jugador)
      if (esEsteElPropietario(jugador))
        jugador.paga(@precioEdificar)
        @numCasas += 1
        puts "Casa construida\n"
        return true
      else
        return false
      end
    end
    
    def construirHotel (jugador)
      if (esEsteElPropietario(jugador))
        jugador.paga(@precioEdificar * (5-@numCasas))
        @numHoteles += 1
        puts "Hotel construido\n"
        return true
      else
        return false
      end
    end
    
    def comprar (jugador)
      if (@tienePropietario)
        puts "\nError: No puede comprar, la casilla ya tiene propietario.\n"
        return false
      else
        @propietario = jugador
        @tienePropietario = true
        jugador.paga(@precioCompra)
        puts "Casa comprada\n"
        return true
      end
    end
    
    def actualizaPropietarioPorConversion (jugador)
      jugador.paga(@precioCompra)
      @propietario = jugador
    end
    
    def vender (jugador)
      if (esEsteElPropietario(jugador) && !jugador.encarcelado)
        puts "Vendiendo casa."
        @propietario = nil
        @tienePropietario = false
        jugador.recibe(getPrecioVenta)
        return true
      else
        puts "#{jugador.nombre} no puede vender, esta encarcelado."
        return false
      end
    end
  end
end
