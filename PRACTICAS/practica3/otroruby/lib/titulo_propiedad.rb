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

    attr_reader :nombre, :num_casas, :num_hoteles, :precio_compra, :precio_edificar, :propietario, :hipotecado
  
  
  
  def actualiza_propietario_por_conversion(jugador)
   
    @propietario = jugador
    
  end
  
  def cancelar_hipoteca(jugador)
    
    if(!@hipotecado && es_este_el_propietario(jugador))
            
      jugador.paga(get_importe_cancelar_hipoteca);
      @hipotecado = false;
      return true;
            
    else
      return false 
        
    
    end
    
  end
  
  
  def cantidad_casas_hoteles
    
    cantidad = @num_casas + @num_hoteles
    return cantidad
    
  end
  
  
  def comprar(jugador)
  
    if(tiene_propietario)
            
      return false
        
    else
            
      actualiza_propietario_por_conversion(jugador);
      jugador.paga(@precio_compra);
      return true    
            
    end
    
  end
  
  def construir_casa(jugador)
   
    construir = false 
    if(es_este_el_propietario(jugador))
            
      jugador.paga(@precio_compra);
      @num_casas+=1
      construir = true
    end
      return construir
    
  end
  
  def construir_hotel(jugador)
    
    result = false 
    if(es_este_el_propietario(jugador))
            
      @propietario.paga(get_precio_edificar)
      @num_casas+=1
      result = true
    end
        return result
    
  end
  
  def derruir_casas(n,jugador)
    
    if(es_este_el_propietario(jugador) && get_num_casas>=n)
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
    return @precio_hipoteca_base
  end
  
  public
  
  
  def get_importe_cancelar_hipoteca
    
    
    cantidad_recibida = (@precio_hipoteca_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)));
    return cantidad_recibida*@@FACTORINTERESESHIPOTECA;
    
  end
  
  private
  def get_precio_alquiler
 
        precio_alquiler = (@precio_alquiler_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)));
        
        if (@hipotecado || propietario_encarcelado)
            
          precio_alquiler=0;
         
        end
        return precio_alquiler;
  end
  
  def get_precio_venta
    
    sum = get_precio_compra + (get_precio_edificar * @factor_revalorizacion)
        return sum 
  end
  
  public
  
  def hipotecar(jugador)
    
    if (!@hipotecado && es_este_el_propietario(jugador))
            
      jugador.recibe(get_importe_hipoteca) 
      @hipotecado = true
      return true
    else
            
      return false
            
    end
    
  end
  
  private
  
  def propietario_encarcelado
    
    if(propietario.is_encarcelado)
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
    
    if (@hipotecado && @propietario )
      return "La propiedad #{@nombre} esta hipotecada. Tiene #{@num_casas} casas, #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."

    else
      return "La propiedad #{@nombre} no esta hipotecada. Tiene #{@num_casas} casas, #{@num_hoteles} hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion #{@factor_revalorizacion}, alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $."

    
    end
  end
  
  def tramitar_alquiler(jugador)
    
    if(tiene_propietario && !es_este_el_propietario(jugador))
      precio = get_precio_alquiler()      
      jugador.paga_alquiler(precio)
      @propietario.recibe(precio)
      
    end
    
  end
  
  
  def vender(jugador)
    
    if(es_este_el_propietario(jugador)&& !@hipotecado)
            
      jugador.recibe(get_precio_venta)
      @propietario=null
      derruir_casas(@num_casas, jugador) #este numCasas es del attr_reader
      @num_hoteles=0
      return true
            
    else
      return false
    
    end
  end
  
  
end
end