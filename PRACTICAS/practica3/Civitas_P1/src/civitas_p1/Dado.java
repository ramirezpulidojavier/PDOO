/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.Random;

/**
 *
 * @author angel
 */
public class Dado {
    
    private Random random;
    private int ultimoResultado;
    private Boolean debug;
    
    public static final Dado instance = new Dado();
    private static int SalidaCarcel = 5;
    
    Dado(){
        
        debug = false;
        ultimoResultado = 0;
        random = new Random();
        
    }
    
    static public Dado getInstance(){
       return instance;
    }
   
    int tirar(){
       
       if (!debug)
           ultimoResultado = random.nextInt(6) + 1;
       
       else
           ultimoResultado = 1;
       
       return ultimoResultado;       
       
    }
   
   Boolean salgoDeLaCarcel(){
       return tirar() >= 5;
   }
   
   int quienEmpieza(int n){
       return random.nextInt(n);
   }
   
   public void setDebug(Boolean d){
       
       debug = d;
       
       if (d)
           Diario.instance.ocurreEvento("El debug se ha puesto a true");
       else
           Diario.instance.ocurreEvento("El debug se ha puesto a false");
       
   }
   
   int getUltimoResultado(){
       return ultimoResultado;
   }   
    
}
