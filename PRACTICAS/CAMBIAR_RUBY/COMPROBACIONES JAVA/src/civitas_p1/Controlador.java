/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

/**
 *
 * @author angelsolano
 */
public class Controlador {

    private CivitasJuego juego;
    private VistaTextual vista;
    
    Controlador(CivitasJuego juego, VistaTextual vista){
        
        this.juego = juego;
        this.vista = vista;
        
    }
    
    void juega(){
        
        vista.setCivitasJuego(juego);

        while(!juego.finalDelJuego()){
            
            int cnt = 0;
            
            if(juego.getJugadorActual().getPuedeComprar())
                System.out.println("\nPuede Comprar\n");
            else
                System.out.println("\nNo puede comprar\n");
            
            
            
            if (cnt > 0)vista.actualizarVista();
            
            vista.pausa();
            OperacionesJuego operacion = juego.siguientePaso();
            int mecagoentodo = 0;
            vista.mostrarSiguienteOperacion(operacion);
            if (operacion != OperacionesJuego.PASAR_TURNO)
                vista.mostrarEventos();

            if (!juego.finalDelJuego()){

                if (operacion == OperacionesJuego.COMPRAR){

                    Respuestas compra = vista.comprar();
                    if (compra == Respuestas.values()[1]){
                        juego.comprar();
                        juego.siguientePasoCompletado(operacion);
                    }

                }
                else if (operacion == OperacionesJuego.GESTIONAR){
                    vista.gestionar();
                    int gestion = vista.getGestion();
                    int propiedad = vista.getPropiedad();
                    GestionesInmobiliarias g_inmobiliaria = GestionesInmobiliarias.values()[gestion];
                    OperacionInmobiliaria o_inmobiliaria= new OperacionInmobiliaria(g_inmobiliaria, propiedad);

                    if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[0]){
                        juego.vender(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[1]){
                        juego.hipotecar(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[2]){
                        juego.cancelarHipoteca(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[3]){
                        juego.construirCasa(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[4]){
                        juego.construirHotel(propiedad);
                    }
                    else if (o_inmobiliaria.getGestion() == GestionesInmobiliarias.values()[5]){
                        juego.siguientePasoCompletado(operacion);
                    }

                }
                else if (operacion == OperacionesJuego.SALIR_CARCEL){
                    SalidasCarcel salida = vista.salirCarcel();

                    if (salida == SalidasCarcel.values()[0])
                        juego.salirCarcelPagando();
                    else
                        juego.salirCarcelTirando();

                    juego.siguientePasoCompletado(operacion);
                }
            }  
            
            cnt ++;
        }
    
    juego.ranking();
    }
}
