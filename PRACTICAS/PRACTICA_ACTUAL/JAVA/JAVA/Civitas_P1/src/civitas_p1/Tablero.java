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
    private ArrayList<CasillaDescanso> casillas;
    private int porSalida;
    private boolean tieneJuez; 
    
    private boolean correcto(){
        return casillas.size() > numCasillaCarcel && tieneJuez;
    }
    
    private boolean correcto(int numCasilla){
        return correcto() && numCasilla >= 0 && numCasilla < casillas.size();
    }
    
    public Tablero(int numCasillaCarcel){
        
        if (numCasillaCarcel > 1)
            this.numCasillaCarcel = numCasillaCarcel;
        else
            this.numCasillaCarcel = 1;
        
        CasillaDescanso salida;
        salida = new CasillaDescanso("Salida");

        casillas = new ArrayList<CasillaDescanso>();
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
    
    void añadeCasilla(CasillaDescanso casilla){
        
        CasillaDescanso carcel;
        carcel = new CasillaDescanso("Carcel");
        
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
            
            CasillaDescanso juez;
            juez = new CasillaJuez("Juez",numCasillaCarcel);
            
            
            añadeCasilla(juez);
            tieneJuez = true;
            
        }
    }
    
    CasillaDescanso getCasilla(int numCasilla){
        
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
    
    public ArrayList<CasillaDescanso> getCasillas(){
        return casillas;
    }
    
    
    
}


