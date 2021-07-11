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
public class CasillaImpuesto extends CasillaDescanso{
    private float importe;
    
    CasillaImpuesto(String nombre, float importe){
    
        super(nombre);
        this.importe=importe;
    
    }
    
    @Override
    void recibeJugador(int iactual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(iactual, todos)){
            informe(iactual, todos);
            todos.get(iactual).pagaImpuesto(importe);
        }
    }
    @Override
    public String toString(){   
        return " llamada " + nombre + " con un valor de "+importe+ " €";
    }
}
