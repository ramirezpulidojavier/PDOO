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
public class Civitas_P1 {

    /**
     * @param args the command line arguments
     */
    
    
    
    public static void main(String[] args) {
 
        VistaTextual prueba = new VistaTextual();
        ArrayList<String> nombres = new ArrayList();
        
        nombres.add("Juan");
        nombres.add("Mario");
        nombres.add("Claudia");
        
        CivitasJuego juego = new CivitasJuego(nombres);
        
        Dado.instance.setDebug(true);
        
        Controlador controlador = new Controlador(juego,prueba);
        
        controlador.juega();
        
    }
    
    
    
}

