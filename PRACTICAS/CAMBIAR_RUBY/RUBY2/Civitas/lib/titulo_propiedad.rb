module Civitas
  class TituloPropiedad
    @@FACTORINTERESESHIPOTECA = 1.1
    public
    attr_accessor :nombre, :factorRevalorizado, :hipoteca_base, :precio_compra, :precio_edificar, :hipotecado, :propietario, :num_casas, :num_hoteles, :alquiler_base
    
    def initialize(nombre = "sin nombre",prec_alq_base = 200,fact_rev = 1.5,prec_baship = 100,prec_compr = 400,prec_edif = 500)
      @nombre = nombre
      @alquiler_base = prec_alq_base
      @factor_revalorizacion = fact_rev
      @precio_hipoteca_base = prec_baship
      @precio_compra = prec_compr
      @precio_edificar = prec_edif
      @propietario = Jugador.new(false , "Undefined", 0, false, 0, nil, nil)
      @hipotecado = false
      @num_casas = 0
      @num_hoteles = 0

  end
    public
    def to_s

    if (@hipotecado)
      return "la propiedad #{@nombre} que ahora pertenece a #{@propietario.nombre} y esta hipotecada. Tiene #{@num_casas} casas,
                    #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion =
                    #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."

    else
      return "la propiedad #{@nombre} que ahora pertenece a #{@propietario.nombre} y no esta hipotecada. Tiene #{@num_casas} casas,
                    #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion =
                    #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."


    end
  end
    
    public
    
    def get_precio_alquiler
      if (@hipotecado or @propietario.encarcelado)
        return 0
      else
        return @alquiler_base + @alquiler_base*@num_casas + @alquiler_base*@num_hoteles*5
      end
    end
    
    def es_este_el_propietario (jugador)
      return jugador == @propietario
    end
    
    def cancelar_hipoteca (jugador)
      if (@hipotecado and es_este_el_propietario(jugador))
        jugador.paga(@hipoteca_base)
        return true
      else
        return false
      end
    end
    
    def hipotecar (jugador)
      if (!@hipotecado and es_este_el_propietario(jugador))
        jugador.recibe(@hipoteca_base)
        return true
      else
        return false
      end
    end
    
    def tramitar_alquiler (jugador)
      if (tiene_propietario and !es_este_el_propietario(jugador))
        jugador.paga(get_precio_alquiler)
        @propietario.recibe(get_precio_alquiler)
      end
    end
    
    def propietario_encarcelado
      return @propietario.encarcelado
    end
    public
    def cantidad_casas_hoteles
      return (@num_casas + @num_hoteles)
    end
    
    def derruir_casas (n, jugador)
      if (es_este_el_propietario(jugador) and @num_casas >= n)
        @num_casas -= n
        return true
      else
        return false
      end
    end
    
    def get_precio_venta
      return @precio_compra + @num_casas * @factor_revalorizacion + 5*@num_hoteles * @factor_revalorizacion
    end
    def construir_imperio( jugador)
        
        construir = false
        
        if (es_este_el_propietario(jugador) && jugador.saldo>@precio_edificar)
            construir = true;
        end
        
        return construir
        
    end
    def construir_casa (jugador)
      if (es_este_el_propietario(jugador))
        jugador.paga(@precio_edificar)
        @num_casas += 1
        puts "Casa construida\n"
        return true
      else
        return false
      end
    end
    
    def construir_hotel (jugador)
      if (es_este_el_propietario(jugador))
        jugador.paga(@precio_edificar * (5-@num_casas))
        @num_hoteles += 1
        puts "Hotel construido\n"
        return true
      else
        return false
      end
    end
    
    def comprar (jugador)
      if (@tiene_propietario)
        puts "\nError: No puede comprar, la casilla ya tiene propietario.\n"
        return false
      else
        @propietario = jugador
        @tiene_propietario = true
        jugador.paga(@precio_compra)
        puts "Casa comprada\n"
        return true
      end
    end
    public

    def tiene_propietario

      return !(@propietario.nombre== "Undefined" || @propietario==nil)

    end
    
    def actualiza_propietario_por_conversion (jugador)
      jugador.paga(@precio_compra)
      @propietario = jugador
    end
    
    def vender (jugador)
      if (es_este_el_propietario(jugador) && !jugador.encarcelado)
        puts "Vendiendo casa."
        @propietario = nil
        @tiene_propietario = false
        jugador.recibe(get_precio_venta)
        return true
      else
        puts "#{jugador.nombre} no puede vender, esta encarcelado."
        return false
      end
    end
  end
end
