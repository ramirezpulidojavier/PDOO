require './tipo_sorpresa'
require './tipo_casilla'
module Civitas
class Casilla

  @@carcel = 8

  def initialize (nombre = "sin_nombre", carcel = 8, importe = 0, tipo = nil, titulo_propiedad = TituloPropiedad.new("UNDEFINED", 0, 0, 0, 0, 0), mazo = nil, sorpresa = nil)

    @nombre = titulo_propiedad.nombre
    @@carcel = carcel
    @importe = importe
    @tipo = tipo
    @titulo_propiedad = titulo_propiedad
    @mazo = mazo
    @sorpresa = sorpresa

  end

  def self.casilla(nombre)
    self.new(nombre, 8, 0, TipoCasilla::DESCANSO, TituloPropiedad.new("UNDEFINED", 0, 0, 0, 0, 0), nil, nil)
  end

  def self.casilla2(titulo_propiedad )

    self.new(titulo_propiedad.nombre, 8, titulo_propiedad.precio_compra, TipoCasilla::CALLE, titulo_propiedad, nil, nil)

  end

  def self.casilla3(cantidad,nombre)

    self.new(nombre, 8, cantidad, TipoCasilla::IMPUESTO, TituloPropiedad.new("UNDEFINED", 0, 0, 0, 0, 0), nil, nil)

  end

  def self.casilla4(num_casilla_carcel, nombre)

    self.new(nombre, num_casilla_carcel, 0, TipoCasilla::JUEZ, TituloPropiedad.new("UNDEFINED", 0, 0, 0, 0, 0), nil, nil)

  end

  def self.casilla5(mazo, nombre)

    self.new(nombre, 8, 0, TipoCasilla::SORPRESA, TituloPropiedad.new("UNDEFINED", 0, 0, 0, 0, 0), mazo, nil)

  end
  attr_reader :nombre, :titulo_propiedad, :tipo
  
  private
    def informe(actual, todos)
      Diario.instance.ocurre_evento(todos[actual].nombre + " ha caido en la casilla: #{to_s}")
      
    end
  
    public
    def to_s

      return "#{@nombre}, la carcel esta en la posicion #{@@carcel}, y la casilla es #{@titulo_propiedad.to_s}\n"

    end
    
    
    def jugador_correcto(iactual,todos)

      return (iactual >= 0 && iactual < todos.size)

    end

    def recibe_jugador(iactual,todos)

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
                informe(iactual,todos) 
              end

    end
    
    private
  def recibe_jugador_calle(iactual,todos)

        if jugador_correcto(iactual, todos)
            informe(iactual, todos)

            if !@titulo_propiedad.tiene_propietario

              todos.at(i).puede_comprar_casilla
            else

                @titulo_propiedad.tramitar_alquiler(todos.at(i))

            end
        end
  end


  def recibe_jugador_impuesto(iactual,todos)

    if (jugador_correcto(iactual, todos))
      informe(iactual, todos)
      todos.at(i).paga_impuesto(@importe)
    end

  end

  def recibe_jugador_juez(iactual,todos)

    if (jugador_correcto(iactual, todos))
      informe(iactual, todos)
      todos.at(i).encarcelar(@@carcel)
    end
  end
    
    def recibe_jugador_sorpresa(iactual,todos)

    if jugador_correcto(iactual,todos)

            @sorpresa = @mazo.siguiente()
            informe(iactual,todos)
            @sorpresa.aplicar_a_jugador(iactual, todos)

    end


  end
    
  end

end
