require_relative 'diario.rb'
require_relative 'casilla.rb'
module Civitas
  class Sorpresa
    
    def initialize(tablero = nil,tipo = nil,valor = 0,texto = "Ninguna",mazo = nil)
      
      @tablero = tablero
      @tipo = tipo
      @valor = valor
      @texto = texto
      @mazo = mazo
      
    end
    
    def self.sorpresa(tablero, tipo)
      self.new(tablero,tipo,-1,nil,nil) 
    end
    
    def self.sorpresa2(tablero, tipo, valor, texto)
      self.new(tablero,tipo,valor,texto,nil) 
    end
    
    def self.sorpresa3(tipo, valor, texto) 
      self.new(nil,tipo,valor,texto,nil) 
    end
    
    def self.sorpresa4(tipo, mazo)
      self.new(nil,tipo,-1,nil,mazo) 
    end
    
    attr_accessor :tipo, :tablero, :valor, :texto
    
    def jugador_correcto(actual, todos)
      return actual < todos.length
    end

    def informe(actual, todos)
      if(jugador_correcto(actual,todos))
        Diario.instance.ocurre_evento("Sorpresa aplicada a: " + todos[actual].nombre)
        puts Diario.instance.leer_evento
      end
    end
    public
    def aplicar_a_jugador(actual, todos)
      case @tipo
      when TipoSorpresa::IRCARCEL
        aplicar_a_jugador_ir_carcel(actual, todos)
      when TipoSorpresa::IRCASILLA
        aplicar_a_jugador_ir_a_casilla(actual, todos)
      when TipoSorpresa::PAGARCOBRAR
        aplicar_a_jugador_pagar_cobrar(actual, todos)
      when TipoSorpresa::PORCASAHOTEL
        aplicar_a_jugador_por_casa_hotel(actual, todos)
      when TipoSorpresa::PORJUGADOR
        aplicar_a_jugador_por_jugador(actual, todos)
      when TipoSorpresa::SALIRCARCEL
        aplicar_a_jugador_salir_carcel(actual, todos)
      end
    end
    
    def aplicar_a_jugador_ir_carcel(actual, todos)
      if (jugador_correcto(actual,todos))
        informe(actual, todos)
        todos[actual].encarcelar(@tablero.num_casilla_carcel)
      end
    end
    
    def aplicar_a_jugador_ir_a_casilla(actual, todos)
      if (jugador_correcto(actual,todos))
        informe(actual, todos)
        casilla_actual = todos[actual].num_casilla_actual
        tirada = @tablero.calcular_tirada(casilla_actual, @valor)
        new_pos = @tablero.nueva_posicion(casilla_actual, tirada)
        todos[actual].mover_a_casilla(new_pos)
        @tablero.get_casilla(new_pos).recibe_jugador(actual, todos)
      end
    end
    
    def aplicar_a_jugador_pagar_cobrar(actual, todos)
      if(jugador_correcto(actual,todos))
        informe(actual, todos)
        todos[actual].modificar_saldo(@valor)
      end
    end
    
    def aplicar_a_jugador_por_casa_hotel(actual, todos)
      if(jugador_correcto(actual, todos))
        informe(actual, todos)
        todos[actual].modificar_saldo(@valor*todos[actual].cantidad_casas_hoteles)
      end
    end
    
    def aplicar_a_jugador_por_jugador(actual, todos)
      if jugador_correcto(actual,todos)
        informe(actual,todos)
        p1 = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, @valor*(-1), "pagar_cobrar")
        
        for i in (0..todos.size - 1)
          if i != actual
            p1.aplicar_a_jugador_pagar_cobrar(i,todos)
          end
          
        end
        
        p2 = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, @valor*(todos.size - 1), "pagar_cobrar")
        p2.aplicar_a_jugador_pagar_cobrar(actual,todos)
      end
    end
    
    def aplicar_a_jugador_salir_carcel(actual, todos)
      if (jugador_correcto(actual, todos))
        informe(actual, todos)
        la_tienen = false
        for i in (0..todos.length-1)
          if (todos.at(i).tiene_salvoconducto)
            la_tienen = true
          end
          if (!la_tienen)
            todos[actual].obtener_salvoconducto(self)
            salir_del_mazo
          end
        end
      end
    end
    
    def salir_del_mazo
      if (@tipo == TipoSorpresa::SALIRCARCEL)
        @mazo.inhabilitar_carta_especial(self)
      end
    end
    
    def usada
      if (@tipo == TipoSorpresa::SALIRCARCEL)
        @mazo.habilitar_carta_especial(self)
      end
    end
    
    def to_s
      return @texto
    end
  end
end