/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author angel
 */
public class SorpresaJugadorEspeculador extends Sorpresa{
    
    private float fianza;
    
    
    SorpresaJugadorEspeculador(String texto, float fianza){
        
        super(texto);
        this.fianza = fianza;
        
    }

    @Override
    void aplicarAJugador(int actual, ArrayList<Jugador> todos) {  
            Jugador player = todos.get(actual);
            todos.set(actual,new JugadorEspeculador(player, fianza));      
    }
    
   
    
}
