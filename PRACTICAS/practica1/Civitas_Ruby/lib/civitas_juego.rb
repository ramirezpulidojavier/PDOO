# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
class CivitasJuego
  
  private
    @indice_jugador_actual
    @jugadores
    @estado
    @gestor_estados
    @tablero
    @mazo
  
  def initialize(nombres)
   
    for i in (0..nombres.size)
            
      nu = Jugador.new(nombres[i])
      @jugadores.push(nu)
            
    end
        
    @estado = @gestor_estados.estado_inicial
    @indice_jugador_actual = Dado.instance.quien_empieza(@jugadores.size)
    @mazo = MazoSorpresas.new
    
  end


  def contabilizar_pasos_por_salida(jugador_actual)
        
    @por_salida = @tablero.get_por_salida
        
    while(@por_salida>0)
      jugador_actual.pasa_por_salida
      @por_salida-=1
    end
  end
  
  def final_del_juego()
        
    for i in (0..@jugadores.size)
      if(@jugadores[i].en_bancarrota)
        return true
            
    return false         
        
      end
    end
  end
  
  def get_casilla_actual()
        
       return @tablero.get_casilla(@jugadores[@indice_jugador_actual].num_casilla_actual)
  end

  def get_jugador_actual()
        
        return @jugadores[@indice_jugador_actual]
  end

  
  def info_jugador_texto()
        
    nuevo = Jugador.new(@jugadores[@indice_jugador_actual])
    info = "Nombre del jugador: #{nuevo.nombre} Esta en la casilla: #{get_casilla_actual} Tiene #{nuevo.get_propiedades.size}  
            propiedades y un saldo de: #{nuevo.saldo}" 
        
  if(nuevo.is_encarcelado)
    info += " Esta encarcelado " 
  else
    info += " No esta encarcelado " 
    
  end
  
  return info
                
  end      
  
  
  
  def inicializar_mazo_sorpresas(mazo)
        
    for i in(0..mazo.get_size)
      @mazo.al_mazo(mazo[i])
    end
  end
    
  def inicializar_tablero(tablero)
        
    @tablero = Tablero.new(tablero.carcel)
    for i in (0..tablero.size)
      @tablero.aniade_casilla(tablero[i])
        
    end
  end
  
  def pasar_turno()
        
        @indice_jugador_actual = @indice_jugador_actual +1 % @jugadores.size
        
  end
    
    
  def ranking()
        
    top = Array.new
    copiar = Array.new
        
    for i in (0..@jugadores.size)
      copiar.push(@jugadores[i])
    end  
        
    cnt = 0 
        
    while (cnt < @jugadores.size)
            
      pos = cnt;
            
      for j in (cnt+1..copiar.size)
                
        if(@jugadores[j].compare_to(@jugadores[j])== -1)
        pos = j 
                
        end
      end
            
      top.push(@jugadores[pos]);
      @jugadores.delete(@jugadores[pos]);
            
      cnt+=1
            
    end
        
        return top
  end
  


  def salir_carcel_pagando()
     
    return @jugadores[@indice_jugador_actual].salir_carcel_pagando
  end
    
  def salir_carcel_tirando()
    
    return @jugadores[indice_jugador_actual].salir_carcel_tirando
  end

  def siguiente_paso_completado(operacion)
     
    @estado = @gestor_estados.siguiente_estado(@jugadores[@indice_jugador_actual], @estado, operacion)
        
  end
    
  def vender(ip)
        
    return @jugadores[@indice_jugador_actual].vender(ip)
        
  end





































end
end