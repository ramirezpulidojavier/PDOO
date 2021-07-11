/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;
import java.util.*;

/**
 *
 * @author angelsolano
 */

public class Tablero {
    
    private int numCasillaCarcel; 
    private ArrayList<Casilla> casillas;
    private int porSalida;
    private boolean tieneJuez; 
    
    private boolean correcto(){
        return casillas.size() > numCasillaCarcel && tieneJuez;
    }
    
    private boolean correcto(int numCasilla){
        return correcto() && numCasilla >= 0 && numCasilla < casillas.size();
    }
    
    public Tablero(int n_carcel){
        
        if (n_carcel >= 1)
            numCasillaCarcel = n_carcel;
        else
            numCasillaCarcel = 1;
        
        Casilla salida;
        salida = new Casilla("Salida",TipoCasilla.DESCANSO);
        
        casillas = new ArrayList<Casilla>();
        casillas.add(salida);
        porSalida = 0;
        tieneJuez = false;
        
    }
    
    int getCarcel(){
        return numCasillaCarcel;
    }
    
    int getPorSalida(){
        
        if (porSalida > 0){
            porSalida --;
            return porSalida + 1;
        }
        else
            return porSalida;
     
    }
    
    int getSize(){                  //Para obtener el tamaño de vector (AYUDA)
        return casillas.size();
    }
    
    void añadeCasilla(Casilla casilla){
        
        Casilla carcel;
        carcel = new Casilla("Carcel", TipoCasilla.DESCANSO);
        
        if (casillas.size() == numCasillaCarcel){
            casillas.add(carcel);
            casillas.add(casilla);           
        }
        else{
            
            casillas.add(casilla);
            
            if (casillas.size() == numCasillaCarcel)
                casillas.add(carcel);
            
        }
            
    }
    
    void añadeJuez(){
        
        if (!tieneJuez){
            
            Casilla juez;
            juez = new Casilla("Juez", TipoCasilla.JUEZ);
            
            añadeCasilla(juez);
            tieneJuez = true;
            
        }
    }
    
    Casilla getCasilla(int numCasilla){
        
        if (correcto(numCasilla))
            return casillas.get(numCasilla);
        else
            return null;
        
    }
    
    int nuevaPosicion(int actual, int tirada){
        
        if(!correcto())
            return -1;
        else{
            
            int nueva_pos;
            
            nueva_pos = (actual + tirada) % casillas.size();
            
            if (nueva_pos != (actual + tirada))
                porSalida ++;
            
            return nueva_pos;
            
        }
                
    }
    
    int calcularTirada(int origen, int destino){
        
        int tirada = destino - origen;
        
        if (tirada < 0)
            return tirada + casillas.size();
        else
            return tirada;
        
        
    }
    
    
    
}


