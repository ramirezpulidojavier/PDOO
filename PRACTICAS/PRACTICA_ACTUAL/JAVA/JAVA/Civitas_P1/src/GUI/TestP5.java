/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GUI;

import java.util.ArrayList;
import civitas_p1.CivitasJuego;


public class TestP5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        CivitasView obj = new CivitasView();
        Dado.createInstance(obj);
        Dado dado = Dado.getInstance();
        dado.setDebug(false);
        CapturaNombres captura = new CapturaNombres(obj, true);
        ArrayList<String> nombres=new ArrayList<>();
        nombres = captura.getNombres();
        
               
        CivitasJuego objeto = new CivitasJuego(nombres);
        Controlador control = new Controlador(objeto, obj);
        obj.setCivitasJuego(objeto);
        
        //obj.actualizarVista();
        
        control.juega();
        
        
    }
    
}
