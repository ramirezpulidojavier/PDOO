# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
  
  class Sorpresa
    
    def initialize(tablero = nil,tipo = nil,valor = 0,texto = nil,mazo = nil)
      
      @tablero = tablero
      @tipo = tipo
      @valor = valor
      @texto = texto
      @mazo = mazo
      
    end
    
    
    def self.sorpresa(tablero, tipo, valor, texto)
      new(tablero,tipo,valor,texto)     
    end
    
    def self.sorpresa2(tipo, valor, texto) 
      new(tipo,valor,texto) 
    end
    
    def self.sorpresa3(tipo, mazo)
      new(tipo,mazo)
    end
    
    def jugador_correcto(actual, todos)
      if (actual >= 0 && actual < todos.size)
        return true
      else
        return false
      end
    end
    
    private
    def informe(actual, todos)
      Diario.instance.ocurre_evento("Se esta aplicando una sorpresa al jugador #{todos[i].nombre}")
    end
    
    public
    def aplicar_a_jugador(actual, todos)
      
      if @tipo == TipoSorpresa::IRCARCEL
        aplicar_a_jugador_ir_carcel(actual, todos)
      
      elsif @tipo == TipoSorpresa::IRCASILLA
        aplicar_a_jugador_ir_a_casilla
        
      elsif @tipo == TipoSorpresa::PAGARCOBRAR
        aplicar_a_jugador_pagar_cobrar
        
      elsif @tipo == TipoSorpresa::PORCASAHOTEL
        aplicar_a_jugador_por_casa_hotel
        
      elsif @tipo == TipoSorpresa::PORJUGADOR
        aplicar_a_jugador_por_jugador
        
      elsif @tipo == TipoSorpresa::SALIRCARCEL
        aplicar_a_jugador_salir_carcel
     
      end
      
    end
    
    private
    def aplicar_a_jugador_ir_carcel(actual, todos)
      if jugador_correcto(actual,todos)
        informe(actual, todos)
        todos[actual].encarcelar(tablero.carcel)
      end
    end
    
    
    def aplicar_a_jugador_ir_a_casilla(actual, todos)
      if jugador_correcto(actual,todos)
        informe(actual, todos)
        casilla_actual = todos[actual].num_casilla_actual
        tirada = @tablero.calcular_tirada(casilla_actual, @valor)
        new_pos = tablero.nueva_posicion(casilla_actual, tirada)
        todos[actual].mover_a_casilla(new_pos)
        #todos[actual].recibeJugador()
      end
     
    end
    
    def aplicar_a_jugador_pagar_cobrar(actual,todos)
      if jugador_correcto(actual,todos)
        informe(actual,todos)
        todos[actual].modificar_saldo(@valor)
      end
    end
    
    def aplicar_a_jugador_por_casa_hotel(actual, todos)
      if jugador_correcto(actual,todos)
        informe(actual,todos)
        todos[actual].modificar_saldo(@valor*todos[actual].cantidad_casas_hoteles)
      end
      
    end
    
    def aplicar_a_jugador_por_jugador(actual,todos)
      if jugador_correcto(actual,todos)
        informe(actual,todos)
        todos[actual].modificar_saldo((-1)*@valor*todos[actual].cantidad_casas_hoteles)
        p1 = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, @valor*(-1), "pagar_cobrar")
        
        
        for i in (0..todos.size - 1)
          if i != actual
            p1.aplicar_a_jugar_pagar_cobrar(i,todos)
          end
          
        end
        
        p2 = Sorpresa.new(TipoSorpresa::PAGARCOBRAR, @valor*(todos.size - 1), "pagar_cobrar")
        p2.aplicar_a_jugar_pagar_cobrar(actual,todos)
      end
    end
    
    def aplicar_a_jugador_salir_carcel(actual,todos)
      if jugador_correcto(actual,todos)
        informe(actual,todos)
        @tienen_carcel = false
        for i in (0..todos.size - 1)
          if i != actual && todos[i].tiene_salvoconducto
            @tienen_carcel = true
          end
        end
        
        if !@tienen_carcel
          
          todos[actual].obtener_salvonconducto(self)
          salirDelMazo()
        end
        
      end
    end
    
    public
    def salir_del_mazo
      if @tipo == TipoSorpresa::SALIRCARCEL
        @mazo.inhabilitarcartaespecial(self)
      end
      
    end
    
    def usada
      if @tipo == TipoSorpresa::SALIRCARCEL
        mazo.habilitar_carta_especial(self)
      end
    end
    
    def to_string
      return @texto
    end
    
    
   
end

end