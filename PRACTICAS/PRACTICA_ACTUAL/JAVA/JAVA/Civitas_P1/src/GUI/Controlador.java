
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GUI;

import civitas_p1.CivitasJuego;
import civitas_p1.GestionesInmobiliarias;
import civitas_p1.Jugador;
import civitas_p1.OperacionInmobiliaria;
import civitas_p1.OperacionesJuego;
import civitas_p1.Respuestas;
import civitas_p1.SalidasCarcel;
import java.util.ArrayList;


public class Controlador {

    private CivitasJuego juego;
    private CivitasView vista;
    
    public Controlador(CivitasJuego juego, CivitasView vista){
        
        this.juego = juego;
        this.vista = vista;
        
    }
    
    
    public void juega(){
        
        vista.setCivitasJuego(juego);

        while(!juego.finalDelJuego()){
            
            int cnt = 0;
                       
            if (cnt > 0)vista.actualizarVista();
            
            //vista.pausa();
            OperacionesJuego operacion = juego.siguientePaso();
            vista.mostrarSiguienteOperacion(operacion);
            if (operacion != OperacionesJuego.PASAR_TURNO)
                vista.mostrarEventos();

            if (!juego.finalDelJuego()){

                if (operacion == OperacionesJuego.COMPRAR){
                    
                        GUI.Respuestas compra = vista.comprar();
                        
                        if (compra == GUI.Respuestas.SI){
                            juego.comprar();
                        
                            juego.siguientePasoCompletado(operacion);
                        }else
                            juego.siguientePasoCompletado(operacion);
                     
                      
                    

                }
                else if (operacion == OperacionesJuego.GESTIONAR){
                    vista.gestionar();
                    int gestion = vista.getGestion();
                    int propiedad = vista.getPropiedad();
                    GestionesInmobiliarias g_inmobiliaria = GestionesInmobiliarias.values()[gestion];
                    OperacionInmobiliaria o_inmobiliaria= new OperacionInmobiliaria(g_inmobiliaria, propiedad);

                    if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.VENDER){
                        juego.vender(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.HIPOTECAR){
                        juego.hipotecar(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.CANCELAR_HIPOTECA){
                        juego.cancelarHipoteca(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.CONSTRUIR_CASA){
                        juego.construirCasa(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.CONSTRUIR_HOTEL){
                        juego.construirHotel(propiedad);
                    }
                    else{ //se supone que es TERMINAR
                        juego.siguientePasoCompletado(operacion);
                    }

                }
                else if (operacion == OperacionesJuego.SALIR_CARCEL){
                    SalidasCarcel salida = vista.salirCarcel();

                    if (salida == SalidasCarcel.PAGANDO)
                        juego.salirCarcelPagando();
                    else
                        juego.salirCarcelTirando();

                    juego.siguientePasoCompletado(operacion);
                }
            }  
            
            cnt ++;
        }
    
    ArrayList<Jugador> top_players = juego.ranking();
    for(int i=0; i<top_players.size();i++){
        System.out.println(i+1);
        System.out.println(top_players.get(i).toString());
    }
    
    }

/*
    void juega(){
        
        vista.setCivitasJuego(juego);
        while(!juego.finalDelJuego()){
            
            vista.actualizarVista();
            
            OperacionesJuego operacionSig = juego.siguientePaso();
            vista.mostrarSiguienteOperacion(operacionSig);
            
            if(operacionSig!=OperacionesJuego.PASAR_TURNO)
                vista.mostrarEventos();
            
            boolean finjuego = juego.finalDelJuego();
        
            if(!finjuego){
            
                switch (operacionSig){
                    case COMPRAR:
                        GUI.Respuestas rep = vista.comprar();
                        if(rep == GUI.Respuestas.SI)
                            juego.comprar();
                        juego.siguientePasoCompletado(operacionSig);
                        break;
                    case GESTIONAR:
                        vista.gestionar();
                        GestionesInmobiliarias gest = GestionesInmobiliarias.values()[vista.getGestion()];
                        int ip = vista.getPropiedad();
                        OperacionInmobiliaria op = new OperacionInmobiliaria(gest, ip);
                        switch (op.getGestion()){
                            case VENDER:
                                juego.vender(ip);
                                break;
                            case HIPOTECAR:
                                juego.hipotecar(ip);
                                break;
                            case CANCELAR_HIPOTECA:
                                juego.cancelarHipoteca(ip);
                                break;
                            case CONSTRUIR_CASA:
                                juego.construirCasa(ip);
                                break;
                            case CONSTRUIR_HOTEL:
                                juego.construirHotel(ip);
                                break;
                            case TERMINAR:
                                juego.siguientePasoCompletado(operacionSig);
                                break;
                                
                        }
                        
                        break;
                    case SALIR_CARCEL:
                        SalidasCarcel sal = vista.salirCarcel();
                        if(sal == SalidasCarcel.PAGANDO)
                            juego.salirCarcelPagando();
                        else
                            juego.salirCarcelTirando();
                        juego.siguientePasoCompletado(operacionSig);
                        break;
                }
            
        }
            
        }
        
        ArrayList<Jugador> top_players = juego.ranking();
                System.out.println("RANKING:");
        for(int i=0; i<top_players.size();i++){
            System.out.println(i+1);
            System.out.println(top_players.get(i).toString());
        }
    }
    */
    
}
