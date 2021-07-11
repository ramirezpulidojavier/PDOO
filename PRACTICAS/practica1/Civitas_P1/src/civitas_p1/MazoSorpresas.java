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
    
    void init(){
        sorpresas = new ArrayList<Sorpresa>();
        cartasEspeciales = new ArrayList<Sorpresa>();
        usadas = 0;
        barajada = false;
    }
    
    Sorpresa getSorpresa(int indice){
        return sorpresas.get(indice);
    }
    
    MazoSorpresas(boolean d){
        
        debug = d;
        
        if (d)
            init();
  
    }
    
    MazoSorpresas(){
        
        init();
        debug = false;
        
    }
    
    void alMazo(Sorpresa s){
        
        if(!barajada)
            sorpresas.add(s);
            
    }
    
    Sorpresa siguiente(){
        
        if((!barajada || usadas == sorpresas.size()) && !debug){
            usadas = 0;
            Collections.shuffle(sorpresas);
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
        
        boolean encontrado = false;
        
        for (int i = 0; i < sorpresas.size() && !encontrado; i++){
            
            if (sorpresas.get(i).getTipo() == sorpresa.getTipo()){
                encontrado = true;
                cartasEspeciales.add(sorpresa);
                sorpresas.remove(i);
                Diario.instance.ocurreEvento("Se ha inhabilitado la sorpresa " + sorpresa.getTipo() + " y se ha puesto en cartas especiales.");
            }
            
        }
        
        
    }
    int getsize(){
        
        return sorpresas.size();
        
    }
    void habilitarCartaEspecial(Sorpresa sorpresa){
        
        boolean encontrado = false;
        
        for (int i = 0; i < cartasEspeciales.size() && !encontrado; i++){
            
            if (cartasEspeciales.get(i).getTipo() == sorpresa.getTipo()){
                encontrado = true;
                sorpresas.add(sorpresa);
                cartasEspeciales.remove(i);
                Diario.instance.ocurreEvento("Se ha habilitado la cartas especial " + sorpresa.getTipo() + " y se ha puesto en sorpresas.");
            }
            
        }
    }
    
}
