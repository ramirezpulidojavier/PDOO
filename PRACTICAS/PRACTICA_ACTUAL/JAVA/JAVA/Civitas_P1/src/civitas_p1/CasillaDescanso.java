/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor. eeeeeeeeeeeeeee
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author javierramirezp   
 */
public class CasillaDescanso {
    
    String nombre;
    
    CasillaDescanso(String nombre){
        
        this.nombre = nombre; 
        
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public boolean jugadorCorrecto(int iactual, ArrayList<Jugador> todos){
        return iactual >= 0 && iactual < todos.size();
    }
    
    
    void informe(int iactual, ArrayList<Jugador> todos){
        
        Diario.instance.ocurreEvento("El jugador " + todos.get(iactual).getNombre() + " ha caido en la casilla " + toString());
        
    }
    void recibeJugador(int iactual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(iactual, todos ) && nombre=="Salida"){
            informe(iactual, todos);
            todos.get(iactual).pasaPorSalida();
        }
    }
    
    @Override
    public String toString(){   
        return " llamada " + nombre ;
    }
    
    
   
}
