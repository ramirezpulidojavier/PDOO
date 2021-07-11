/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author angelsolano
 */

public class SorpresaIrCarcel extends Sorpresa{

    private Tablero tablero;
    
    SorpresaIrCarcel(Tablero tablero, String texto){
        super(texto);
        this.tablero = tablero;
        
    }

    @Override
     void aplicarAJugador(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).encarcelar(tablero.getCarcel());   
        }
    }
    
    
    
}
