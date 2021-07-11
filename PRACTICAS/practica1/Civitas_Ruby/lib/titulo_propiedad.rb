# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
class TituloPropiedad
  
    @@FACTORINTERESESHIPOTECA = 1.1
 
  
  def initialize(nombre,prec_alq_base,fact_rev,prec_baship,prec_compr,prec_edif)
    @nombre = nombre
    @alquiler_base = prec_alq_base
    @factor_revalorizacion = fact_rev
    @precio_hipoteca_base = prec_baship
    @precio_compra = prec_compr
    @precio_edificar = prec_edif
    @propietario = null
    @hipotecado = false
    @num_casas = @num_hoteles = 0
    
  end
  
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
  
  
  def cantidad_casas_hoteles()
    
    cant = get_num_casas + get_num_hoteles
    return cant
    
  end
  
  
  def comprar(jugador)
  
    if(tiene_propietario)
            
      return false
        
    else
            
      actualiza_propietario_por_conversion(jugador);
      jugador.paga(get_precio_compra);
      return true    
            
    end
  end
  
  def construir_casa(jugador)
   
    prop = false 
    if(es_este_el_propietario(jugador))
            
      jugador.paga(get_precio_compra);
      @num_casas+=1
      prop = true
      return prop
    end
        return prop
    
  end
  
  def construir_hotel(jugador)
    
    prop = false 
    if(es_este_el_propietario(jugador))
            
      jugador.paga(get_precio_compra)
      @num_hoteles+=1
      prop = true
      return prop
    end
        return prop
    
  end
  
  def derruir_casas(n,jugador)
    
    if(es_este_el_propietario(jugador) && get_num_casas>=n)
      @num_casas = @num_casas-n
      return true
            
    else
      return false
    
    end
  end
  
  
  def es_este_el_propietario(jugador)
    
    return @propietario == jugador
    
  end
  
  
  private :es_este_el_propietario
  
  attr_reader :hipotecado    #ESTE ES PUBLIC PERO NO SE COMO SE PONE
  
  
  def get_importe_cancelar_hipoteca()
    
    
    cantidad_recibida = (@precio_hipoteca_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)));
    return cantidad_recibida*@@FACTORINTERESESHIPOTECA;
    
  end
  
  
  attr_reader :precio_hipoteca_base
  
  private :precio_hipoteca_base  #creo que esto ya esta puesto en la declaracion del atributo
  
  
  attr_reader :nombre, :num_casas, :num_hoteles
  
  
  def get_precio_alquiler()
 
        precio_alquiler = (@precio_alquiler_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)));
        
        if (@hipotecado || propietario_encarcelado)
            
          precio_alquiler=0;
         
        end
        return precio_alquiler;
  end
    
        
  
  private :get_precio_alquiler
  
  attr_reader :precio_compra, :precio_edificar
  
  def get_precio_venta()
    
    sum = get_precio_compra + (get_precio_edificar * @factor_revalorizacion)
        return sum 
  end
  
  private :get_precio_venta
  
  attr_reader :propietario
  
  def hipotecar(jugador)
    
    if (!@hipotecado && es_este_el_propietario(jugador))
            
      jugador.recibe(get_importe_hipoteca) 
      @hipotecado = true
      return true
    else
            
      return false
            
    end
    
  end
  
  def propietario_encarcelado()
    
    if(propietario.is_encarcelado)
      return true
    else
      return false
    
    end
  end
  
  private :propietario_encarcelado
  
  def tiene_propietario()
    
    return @propietario!=null
    
  end
  
  
  def to_string()
    
    if (@hipotecado)
      return "La propiedad #{@nombre} pertenece a #{@propietario.nombre} y está hipotecada. Tiene #{@num_casas} casas, #{@num_hoteles}
              hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion #{@factor_revalorizacion}
              , alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $.";
    else
      return "La propiedad #{@nombre} pertenece a #{@propietario.nombre} y no está hipotecada. Tiene #{@num_casas} casas, #{@num_hoteles}
              hoteles, precio de compra #{@precio_compra} $, precio edificar #{@precio_edificar} $, factor de revalorizacion #{@factor_revalorizacion}
              , alquiler base de #{@alquiler_base} $ y una hipoteca base de #{@precio_hipoteca_base} $.";
    
    end
  end
  
  public :to_string
  
  def tramitar_alquiler(jugador)
    
    if(tiene_propietario && !es_este_el_propietario(jugador))
            
      jugador.paga_alquiler(get_precio_alquiler)
      @propietario.recibe(get_precio_alquiler)  #este propietario es del attr_reader
            
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