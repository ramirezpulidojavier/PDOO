/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author javierramirezp
 */
public class CasillaCalle extends CasillaDescanso{
    private TituloPropiedad tituloPropiedad;
    
    CasillaCalle(String nombre,  TituloPropiedad tituloPropiedad){
    
        super(nombre);
        this.tituloPropiedad=tituloPropiedad;
    
    }
    @Override
     void recibeJugador(int iactual, ArrayList<Jugador> todos){
        
        if(jugadorCorrecto(iactual, todos)){
            
            informe(iactual, todos);
                  
            if(!tituloPropiedad.tienePropietario()){
                
                todos.get(iactual).puedeComprarCasilla();
            }else{
                
                tituloPropiedad.tramitarAlquiler(todos.get(iactual));
                      
                
            }
           
        }
       
    }
    public TituloPropiedad getTituloPropiedad(){
        return tituloPropiedad;
    }
    @Override
    public String toString(){   
        return " llamada " + nombre + " y " + tituloPropiedad.toString();
    }
}
