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
public class CasillaJuez extends CasillaDescanso{
    private static int carcel;
    
    CasillaJuez(String nombre, int carcel){
    
        super(nombre);
        this.carcel=carcel;
    
    }
    @Override
     void recibeJugador(int iactual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(iactual, todos)){
            informe(iactual, todos);
            todos.get(iactual).encarcelar(carcel);
        }              
    }
    @Override
    public String toString(){   
        return " llamada" + nombre + " con la carcel en la posicion "+carcel;
    }
}
