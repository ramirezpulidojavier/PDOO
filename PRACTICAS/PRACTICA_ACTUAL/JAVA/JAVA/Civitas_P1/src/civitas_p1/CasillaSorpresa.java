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
public class CasillaSorpresa extends CasillaDescanso{
   private MazoSorpresas mazo;
   private Sorpresa sorpresa;
   
   public CasillaSorpresa(String nombre, MazoSorpresas mazo){
       super(nombre);
       this.mazo = mazo;
       sorpresa = null;
   }
   @Override
     void recibeJugador(int iactual, ArrayList<Jugador> todos){
    
        if(jugadorCorrecto(iactual,todos)){

            sorpresa = mazo.siguiente();
            informe(iactual,todos);
            sorpresa.aplicarAJugador(iactual, todos);

        }
        
    }
    @Override
    public String toString(){   
        return " llamada " + nombre + " con una sorpresa de tipo " +sorpresa.toString();
    }
}
