/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JuegoTexto;

import JuegoTexto.Controlador;
import JuegoTexto.VistaTextual;
import civitas_p1.CivitasJuego;
import civitas_p1.Dado;

import java.util.ArrayList;

/**
 *
 * @author angelsolano
 */
public class JuegoTexto {

    /**
     * @param args the command line arguments
     */
    
    
    
    public static void main(String[] args) {
 
        VistaTextual prueba = new VistaTextual();
        ArrayList<String> nombres = new ArrayList();
        
        nombres.add("Angel");
        nombres.add("ManuElPupas");
        nombres.add("JaviBuenasMalasNoticias");
        
        CivitasJuego juego = new CivitasJuego(nombres);
        
        Dado.instance.setDebug(false);
        
        Controlador controlador = new Controlador(juego,prueba);
        
        controlador.juega();
        
    }
    
    
    
}

