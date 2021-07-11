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
public class SorpresaSalirCarcel extends Sorpresa{
    
    private MazoSorpresas mazo;
    
    SorpresaSalirCarcel(MazoSorpresas mazo, String texto){
        
        super(texto);
        this.mazo = mazo;

    }
    
  
    
    @Override
    public void aplicarAJugador(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            Boolean tienenCarcel = false;
            for (int i = 0; i < todos.size() && !tienenCarcel; i++){
                if (i!=actual)
                    if (todos.get(i).tieneSalvoconducto())
                        tienenCarcel = true;
            }
            
            if(!tienenCarcel){
                    todos.get(actual).obtenerSalvoconducto(this);
                    salirDelMazo();
            }
            
            
        }
    }
    
    void salirDelMazo(){
            mazo.inhabilitarCartaEspecial(this);
    }
    
    void usada (){
            mazo.habilitarCartaEspecial(this);
    }
}
