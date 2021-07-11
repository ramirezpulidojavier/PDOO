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
public class SorpresaIrCasilla extends Sorpresa{
    
    private Tablero tablero;
    private int valor; 
    
    SorpresaIrCasilla( Tablero tablero, int valor, String texto){
        super(texto);
        this.tablero = tablero;
        this.valor = valor;
        
    }
    
  
    
    @Override
     void aplicarAJugador(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            int casillaActual = todos.get(actual).getNumCasillaActual();
            int tirada = tablero.calcularTirada(casillaActual, valor);
            int new_pos = tablero.nuevaPosicion(casillaActual, tirada);
            todos.get(actual).moverACasilla(new_pos);
            tablero.getCasilla(new_pos).recibeJugador(actual,todos);
        }
    }
    
}
