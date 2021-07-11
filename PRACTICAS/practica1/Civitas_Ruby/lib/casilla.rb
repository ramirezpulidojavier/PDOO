require './tipo_sorpresa'
require './tipo_casilla'
module Civitas
class Casilla
  
  
  @@carcel
 
  
  def initialize (nombre = "sin_nombre", carcel = 0, importe = 0, tipo = nil, titulo_propiedad = nil, mazo = nil, sorpresa = nil)
    
    @nombre = nombre  
    @@carcel = carcel
    @importe = importe
    @tipo = tipo
    @titulo_propiedad = titulo_propiedad
    @mazo = mazo
    @sorpresa = sorpresa
    
  end
  
  def self.casilla(titulo_propiedad )
   
    self.new("sin_nombre", 0, 0, nil, titulo_propiedad, nil, nil)
    
  end
  
  def self.casilla2(cantidad,nombre)
    
    self.new(nombre, 0, cantidad, nil, nil, nil, nil)
    
  end
  
  def self.casilla3(num_casilla_carcel, nombre)
    
    self.new(nombre, num_casilla_carcel, 0, nil, nil, nil, nil)
    
  end
  
  def self.casilla4(mazo, nombre)
   
    self.new(nombre, 0, 0, nil, nil, mazo, nil)
    
  end
  
  
  attr_reader :nombre          #es el getNombre()
  attr_reader :titulo_propiedad
  
  def informe(iactual,todos)
    
    Diario.instance.ocurre_evento("El jugador " + todos[iactual].nombre + "ha caido en la casilla")
    to_string
    
  end
  private :informe

  
  def jugador_correcto(iactual,todos)
    
    
    return (iactual > 0 && iactual < todos.size)
    
  end
  
  public :jugador_correcto
  
  def recibe_jugador(iactual,todos)
    
    
    
  end
  
  def recibe_jugador_calle(iactual,todos)
    
  end
  
  private :recibe_jugador_calle
  
  def recibe_jugador_impuesto(iactual,todos)
    
    if (jugador_correcto(iactual, todos))    
      informe(iactual, todos)
      todos[iactual].paga_impuesto(@importe)
            
        
    end
  end
  
  private :recibe_jugador_impuesto
  
  def recibe_jugador_juez(iactual,todos)
    
    if (jugador_correcto(iactual, todos))
      informe(iactual, todos)
      todos[iactual].encarcelar(@carcel)
        
    
    end
  end
  
  private :recibe_jugador_juez
  
  
  def recibe_jugador_sorpresa(iactual,todos)
    
  end
  
  private :recibe_jugador_sorpresa
  
  def to_string()
    puts "Nombre: #{@nombre} y su importe es de: #{@importe} y es de tipo: #{@tipo} y la posicion en la carcel es: #{@@carcel}"
  end
  
  public :to_string
  
  
  
end
end
