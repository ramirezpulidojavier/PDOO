# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
class TituloPropiedad
  
    @@FACTORINTERESESHIPOTECA = 1.1
 
  
  def initialize(nombre = "sin nombre",prec_alq_base = 200,fact_rev = 1.5,prec_baship = 100,prec_compr = 400,prec_edif = 500)
    @nombre = nombre
    @alquiler_base = prec_alq_base
    @factor_revalorizacion = fact_rev
    @precio_hipoteca_base = prec_baship
    @precio_compra = prec_compr
    @precio_edificar = prec_edif
    @propietario = nil
    @hipotecado = false
    @num_casas = 0
    @num_hoteles = 0
    
  end

    attr_reader :nombre, :num_casas, :num_hoteles, :precio_compra, :precio_edificar, :propietario, :hipotecado,
                :factor_revalorizacion, :alquiler_base, :precio_hipoteca_base
              
  
  
  
  def actualiza_propietario_por_conversion(jugador)
   
    @propietario = jugador
    
  end
  
  def cancelar_hipoteca(jugador)
    
    result = false
    
    if(!@hipotecado && es_este_el_propietario(jugador))
            
      jugador.paga(get_importe_cancelar_hipoteca)
      result = true
      @hipotecado = false
    end
    return result
  end
  
  
  def cantidad_casas_hoteles
    
    cantidad = @num_casas + @num_hoteles
    return cantidad
    
  end
  
  
  def comprar(jugador)
  
    result = false
    
    if(!tiene_propietario)
              
      actualiza_propietario_por_conversion(jugador)
      result = true
      jugador.paga(@precio_compra) 
            
    end
    return result
  end
  
  def construir_casa(jugador)
   
    construir = false 
    if es_este_el_propietario(jugador)
            
      jugador.paga(@precio_edificar)
      @num_casas+=1
      construir = true
    end
      return construir
    
  end
  
  def construir_hotel(jugador)
    
    result = false 
    if es_este_el_propietario(jugador)
            
      @propietario.paga(@precio_edificar)
      @num_hoteles+=1
      result = true
    end
        return result
    
  end
  
  def derruir_casas(n,jugador)
    
    if(es_este_el_propietario(jugador) && n <= @num_casas)
      @num_casas = @num_casas-n
      return true
            
    else
      return false
    
    end
  end
  
  private
  
  def es_este_el_propietario(jugador)
    
    return @propietario == jugador
    
  end
  
  def get_importe_hipoteca
    return @precio_hipoteca_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5))
  end
  
  public
  
  
  def get_importe_cancelar_hipoteca
    

    return @precio_hipoteca_base*@@FACTORINTERESESHIPOTECA
    
  end
  
  private
  def get_precio_alquiler
    
        if (@hipotecado || propietario_encarcelado)
            
          precio_alquiler=0
        else
          precio_alquiler = (@alquiler_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)))
        end
        return precio_alquiler
  end
  
  def get_precio_venta
    
    sum = @precio_compra + (@num_casas + 5 * @num_hoteles) * @precio_edificar * @factor_revalorizacion
        return sum 
  end
  
  public
  
  def hipotecar(jugador)
    
    if (!@hipotecado && es_este_el_propietario(jugador))
            
      jugador.modificar_saldo(@precio_hipoteca_base)
      @hipotecado = true
      return true
    else
            
      return false
            
    end
    
  end
  
  private
  
  def propietario_encarcelado
    
    if( @propietario != nil && @propietario.encarcelado)
      return true
    else
      return false
    
    end
  end
  
  public
  
  def tiene_propietario
    
    return @propietario!=nil
    
  end
  
  
  def to_s
    
    if (@hipotecado)
      return "la propiedad #{@nombre}, que ahora pertenece a #{@propietario.nombre} y esta hipotecada. Tiene #{@num_casas} casas, 
                     #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion = 
                    #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."

    else
      return "la propiedad #{@nombre}, que ahora pertenece a #{@propietario.nombre} y no esta hipotecada. Tiene #{@num_casas} casas, 
                     #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion = 
                    #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."

    
    end
  end
  
  def tramitar_alquiler(jugador)
    
    
    
    if tiene_propietario && !es_este_el_propietario(jugador)
      precio = @alquiler_base    
      jugador.paga_alquiler(precio)
      @propietario.recibe(precio)
      
    end
    
  end
  
  
  def vender(jugador)
    
    if(es_este_el_propietario(jugador)&& !@hipotecado)
            
      @propietario.recibe(get_precio_venta)
      derruir_casas(@num_casas, @propietario)
      @num_hoteles=0
      @propietario = nil
      puts "\nEl jugador #{jugador.nombre} ha vendido la propiedad #{@nombre} y su saldo es de #{jugador.saldo}\n"
      return true
            
    else
      puts "\nEl jugador #{jugador.nombre} no ha vendido la propiedad #{@nombre} y su saldo es de #{jugador.saldo}\n"
      return false
    
    end
  end
  
  
end
end