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
public class SorpresaPorJugador extends Sorpresa{
    
    private int valor; 
    
    SorpresaPorJugador(int valor, String texto){
        
        super(texto);
        this.valor = valor;
        
    }
    @Override
    void aplicarAJugador(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            //Sorpresa p1 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor*(-1), "PagarCobrar");
            SorpresaPagarCobrar p1 = new SorpresaPagarCobrar(valor*(-1), "PAGARCOBRAR");
        
            for (int i = 0; i < todos.size(); i++)
                if (i != actual)
                    p1.aplicarAJugador(i,todos);
        
            //Sorpresa p2 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor*(todos.size() - 1), "PagarCobrar");
            SorpresaPagarCobrar p2 = new SorpresaPagarCobrar(valor*(todos.size()-1), "PAGARCOBRAR");
            p2.aplicarAJugador(actual,todos);
        }
    }
     
    
    
    
}
