require './Operaciones_juego'
require './casilla'
require './civitas'
require './diario'
require './estados_juego'
require './mazo_sorpresas'
require './sorpresa'
require './tablero'
require './tipo_casilla'
require './tipo_sorpresa'
require './dado'

module Civitas
  


class TestP1
  
  def self.main
    
    
    
    #Punto 1
    
    c0=0
    c1=0
    c2=0
    c3=0
    
    #dado = Dado.send :new
    
    for i in(0..99)
      
      num = Dado.instance.quienempieza(4)
      
      if(num==0)
        
        c0 += 1
        
      end
        
      if (num==1)
          
          c1 += 1
      end
      
      
      if (num==2)
          
          c2 += 1
      end  
      
      
      if (num==3)
          
          c3 += 1
            
      end
    
    
    end
    
    puts c0
    puts c1
    puts c2
    puts c3
    
    #Punto 2
    
    for i in (0..40)
      
      if(i < 20)
       
        tirada = Dado.instance.tirar
        puts tirada
      else
       
        #Dado.instance.setdebug(true)     lo quito para probar el ocurre evento
        tirada = Dado.instance.tirar
        puts tirada
        
      end
     
    end
      
   #Punto 3
   
    res = Dado.instance.getultimoresultado
    puts "Resultado final: #{res}"
    
    
    
    if(Dado.instance.salgodelacarcel)
      puts "puedes salir de la carcel"
    else
      puts "no puedes salir de la carcel"
    end
    
    
    #Punto 4
    
    puts TipoCasilla::CALLE
    puts TipoSorpresa::IRCARCEL
    puts Estados_juego::DESPUES_CARCEL
    
    #Punto 5
    
    valor = true
    mazo = MazoSorpresas.new(valor)
    mazo.almazo("nueva")
    mazo.almazo("otra")
    mazo.siguiente
    mazo.inhabilitarcartaespecial("otra")
    mazo.habilitarcartaespecial("otra")
    puts Diario.instance.leer_evento
    puts Diario.instance.leer_evento
    
    pendiente = Diario.instance.eventos_pendientes
    puts pendiente
    
    #Punto 6
    
    
    
    
    #Punto 7

    tab = Tablero.new(4)
    
    for i in (0..12)
      
      if i < 5
        
        s = Casilla.new("salida")
        tab.aniadecasilla(s)
        
      end
      
      if i == 5
        
        j = Casilla.new("carcel")
        tab.aniadecasilla(j)
        
      end
      
      if i == 6
        
        k = Casilla.new("descanso")
        tab.aniadecasilla(k)
        
      end
      
      if i == 7
        
        l = Casilla.new("impuesto")
        tab.aniadecasilla(l)
        
      end
      
      if i == 8
        
        m = Casilla.new("calle")
        tab.aniadecasilla(m)
        
      end
      
      Dado.instance.setdebug(true)
      
      for i in (0..12)
        
        Dado.instance.tirar
        ul = Dado.instance.getultimoresultado
        puts ul 
        tab.getcasilla(numCasilla)
        
      end
      
      
    end
    
    
    
  end
    
  main  
    
  end
  
  
  end
  

