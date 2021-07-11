#eoooeo
require './tipo_sorpresa'
require './tipo_casilla'
module Civitas
class Casilla  
  
  @@carcel = 1

  def initialize (nombre = "sin_nombre", carcel = 0, importe = 0, tipo = nil, titulo_propiedad = nil, mazo = nil, sorpresa = nil)
    
    @nombre = nombre  
    @@carcel = carcel
    @importe = importe
    @tipo = tipo
    @titulo_propiedad = titulo_propiedad
    @mazo = mazo
    @sorpresa = sorpresa
    
  end
  
  def self.casilla(nombre)
    self.new(nombre, 0, 0, TipoCasilla::DESCANSO, nil, nil, nil)
  end
  
  def self.casilla2(titulo_propiedad )
   
    self.new("sin_nombre", 0, 0, TipoCasilla::CALLE, titulo_propiedad, nil, nil)
    
  end
  
  def self.casilla3(cantidad,nombre)
    
    self.new(nombre, 0, cantidad, TipoCasilla::IMPUESTO, nil, nil, nil)
    
  end
  
  def self.casilla4(num_casilla_carcel, nombre)
    
    self.new(nombre, num_casilla_carcel, 0, TipoCasilla::JUEZ, nil, nil, nil)
    
  end
  
  def self.casilla5(mazo, nombre)
   
    self.new(nombre, 0, 0, TipoCasilla::SORPRESA, nil, mazo, nil)
    
  end
  
  attr_reader :nombre, :titulo_propiedad
  
  private
  def informe(iactual,todos)
    
    Diario.instance.ocurre_evento("El jugador ha caido en la casilla. Informacion de casilla: #{todos.get(iactual).to_s}")

  end

  public
  def jugador_correcto(iactual,todos)   
    
    return (iactual > 0 && iactual < todos.size)
    
  end
  
  def recibe_jugador(iactual,todos)

    if @tipo==nil
            informe(iactual, todos)

        else
            case @tipo
              when TipoCasilla::CALLE
                recibe_jugador_calle(iactual, todos)

             when TipoCasilla::IMPUESTO
                recibe_jugador_impuesto(iactual, todos)

            when TipoCasilla::JUEZ
                recibe_jugador_juez(iactual, todos)

            when TipoCasilla::SORPRESA
                recibe_jugador_sorpresa(iactual, todos)
            else
              informe(iactual,todos) #creo que esto equivale al default de java
            end


    end

  end
  
  private
  def recibe_jugador_calle(iactual,todos)
    jugador = Jugador.new("jugador")
        
        if(jugador_correcto(iactual, todos))
            informe(iactual, todos);
            nuevo = Jugador.new(todos[iactual])
         
            
            if !@titulo_propiedad.tiene_propietario
                
                jugador.puede_comprar_casilla
                
            end 
        
            else
                
                @titulo_propiedad.tramitar_alquiler(jugador)
             
                
            end
            
    end
  
  
  def recibe_jugador_impuesto(iactual,todos)
    
    if (jugador_correcto(iactual, todos))    
      informe(iactual, todos)
      todos[iactual].paga_impuesto(@importe)       
    end
    
  end
  
  def recibe_jugador_juez(iactual,todos)
    
    if (jugador_correcto(iactual, todos))
      informe(iactual, todos)
      todos[iactual].encarcelar(@carcel)
        
    
    end
  end 
  
  def recibe_jugador_sorpresa(iactual,todos)

    if jugador_correcto(iactual,todos)

            sorpresa = @mazo.siguiente()
            informe(iactual,todos)
            sorpresa.aplicar_a_jugador(iactual, todos)

    end


  end
  
  public
  
  def to_s
    puts "Nombre: #{@nombre} y su importe es de: #{@importe} y es de tipo: #{@tipo} y la posicion en la carcel es: #{@@carcel}"
  end

  
end
end
