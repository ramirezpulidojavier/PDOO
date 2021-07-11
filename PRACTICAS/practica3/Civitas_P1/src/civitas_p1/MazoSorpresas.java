/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author angel y el javi lee
 */
public class MazoSorpresas {
    
    private ArrayList<Sorpresa> sorpresas;
    private boolean barajada;
    private int usadas;
    private boolean debug;
    private ArrayList<Sorpresa> cartasEspeciales;
    private Sorpresa ultimaSorpresa;
    
    private void init(){
        sorpresas = new ArrayList<Sorpresa>();
        cartasEspeciales = new ArrayList<Sorpresa>();
        usadas = 0;
        barajada = false;
        ultimaSorpresa = null;
    }
    
    MazoSorpresas(Boolean debug){
        
        this.debug = debug;
        
        if (debug){
            init();
            Diario.instance.ocurreEvento("Modo debug activado");
        }
        else
            Diario.instance.ocurreEvento("Modo debug no activado");
  
    }
    
    MazoSorpresas(){
        
        init();
        debug = false;
        
    }
    
    int getSize(){
        return sorpresas.size();
    }
    
    void alMazo(Sorpresa sorpresa){
        
        if(!barajada)
            sorpresas.add(sorpresa);
            
    }
    
    Sorpresa siguiente(){
        
        if((!barajada || usadas == sorpresas.size()) && !debug){
            Collections.shuffle(sorpresas);
            usadas = 0;
            barajada = true;
        }
        
        int util = sorpresas.size();
        
        usadas ++;
        
        ultimaSorpresa = sorpresas.get(0);
        
        for(int i = 1; i < util; i++){
            
            sorpresas.set(i - 1, sorpresas.get(i));
            
        }
       
        sorpresas.set(util - 1, ultimaSorpresa);
        
        return ultimaSorpresa;
    }
    
    void inhabilitarCartaEspecial (Sorpresa sorpresa){
          
            if (this.sorpresas.contains(sorpresa)){             
                cartasEspeciales.add(sorpresa);
                Diario.instance.ocurreEvento("Se ha inhabilitado la sorpresa " + sorpresa.toString() + " y se ha puesto en cartas especiales.");
                sorpresas.remove(sorpresa);
                
            }
            
    }
    
    void habilitarCartaEspecial(Sorpresa sorpresa){
        
        
            if (this.cartasEspeciales.contains(sorpresa)){
                sorpresas.add(sorpresa);
                Diario.instance.ocurreEvento("Se ha habilitado la cartas especial " + sorpresa.toString() + " y se ha puesto en sorpresas.");
                cartasEspeciales.remove(sorpresa);
                
            }
            
    }

    
}
