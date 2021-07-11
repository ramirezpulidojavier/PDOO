# encoding: utf-8

module Civitas
class TituloPropiedad
  @@factor_intereses_hipoteca=1.1
  
  
  def initialize(nom,ab,fr,hb,pc,pe)
    @nombre=nom
    @alquiler_base=ab
    @factor_revalorizacion=fr
    @hipoteca_base=hb
    @precio_compra=pc
    @precio_edificar=pe
    @num_casas=0
    @num_hoteles=0
    @hipotecado=false
    @propietario = nil
  end
  
  attr_reader   :hipotecado,  :nombre, :num_casas, :num_hoteles, :precio_compra, :precio_edificar, :propietario
  
#  ATTR get_hipotecado, get_importe_hipoteca, get_importe_cancelar_hipoteca....get_propietario
  def get_importe_hipoteca
    @hipoteca_base*(1+@num_casas*0.5+@num_hoteles*2.5)
  end
  
  def get_importe_cancelar_hipoteca
    (@hipoteca_base*(1+@num_casas*0.5+@num_hoteles*2.5))*@@factor_intereses_hipoteca
  end
  
  def get_precio_alquiler
    if @hipotecado||propietario_encarcelado
      return 0
    else
      return @alquiler_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5))
    end
  end
  
  def get_precio_venta
    @precio_compra+(@num_casas+5*@num_hoteles)*@precio_edificar*@factor_revalorizacion
  end
  
  def actualiza_propietario_por_conversion(jugador)
    @propietario=jugador
  end
  
  def cancelar_hipoteca(jugador)
    operacion=false
    if @hipotecado&&jugador==@propietario
      operacion=true
      @propietario.paga(get_importe_cancelar_hipoteca)
      @hipotecado=false
    end
      operacion
  end
  
  def cantidad_casas_hoteles
    @num_casas+@num_hoteles
  end
  
  def comprar(jugador)
    operacion=false
    if @propietario==nil
      @propietario=jugador
      @propietario.paga(@precio_compra)
      operacion=true
    end
    return operacion
  end
  
  def construir_casa(jugador)
    operacion=false
    if es_este_el_propietario(jugador)
      @propietario.paga(@precio_edificar)
      @num_casas+=1
      operacion=true
    end
    return operacion
  end
  
  def construir_hotel(jugador)
    operacion=false
    if es_este_el_propietario(jugador)
      operacion=true
      @propietario.paga(@precio_edificar)
      @num_casas-=4
      @num_hoteles+=1
    end
    return operacion
  end
  
  def derruir_casas(n,jugador)
    operacion=false
    if es_este_el_propietario(jugador)&&@num_casas>=n
      operacion=true
      @num_casas-=n
    end
    return operacion
  end
  
  def es_este_el_propietario(jugador)
    return @propietario==jugador
  end
  
  def hipotecar(jugador)
    operacion=false
    if !@hipotecado&&es_este_el_propietario(jugador)
      operacion=true
      @propietario.recibe(@hipoteca_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5)))
      @hipotecado=true
    end
    return operacion
  end
  
  def propietario_encarcelado
    if tiene_propietario
      return @propietario.is_encarcelado
    else
      return false
    end
  end
  
  def tiene_propietario
    return @propietario!=nil
  end
  
  def to_s
    return      "\n  alquilerBase: "+@alquiler_base.to_s+
                "\n  factorInteresesHipoteca: "+@@factor_intereses_hipoteca.to_s+
                "\n  factorRevalorizacion: "+@factor_revalorizacion.to_s+
                "\n  hipotecaBase:"+@hipoteca_base.to_s+
                "\n  hipotecado: "+@hipotecado.to_s+
                "\n  numCasas:"+@num_casas.to_s+
                "\n  numHoteles:"+@num_hoteles.to_s+
                "\n  precioCompra: "+@precio_compra.to_s+
                "\n  precioEdificar:"+@precio_edificar.to_s+
                "\n  propietario: "+@propietario.to_s;
  end
  
  def tramitar_alquiler(jugador)
    if tiene_propietario&&!es_este_el_propietario(jugador)
      cantidad=@alquiler_base*(1+(@num_casas*0.5)+(@num_hoteles*2.5))
      jugador.paga_alquiler(cantidad)
      @propietario.recibe(cantidad)
    end
  end
  
  def vender(jugador)
    operacion=false
    if es_este_el_propietario(jugador)&&!@hipotecado
      operacion=true
      @propietario.recibe(get_precio_venta)
      @propietario=nil
      @num_casas=0
      @num_hoteles=0
    end
    return operacion
  end
end
end