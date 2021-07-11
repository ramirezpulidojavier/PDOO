/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor. eeeeeeeeeeeeeee
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author angelsolano
 */
public class Casilla {
    
    private String nombre;
    private static int carcel;
    private float importe;
    private TipoCasilla tipo;
    private TituloPropiedad tituloPropiedad;
    private MazoSorpresas mazo;
    private Sorpresa sorpresa;
    
   
    Casilla(String nombre){
        
        init();
        this.nombre = nombre;
        tipo = TipoCasilla.DESCANSO;
        
    }
    
    Casilla(TituloPropiedad titulo){
        init();
        tituloPropiedad = titulo;
        nombre = titulo.getNombre();
        tipo = TipoCasilla.CALLE;       
        importe = titulo.getPrecioCompra();
    }
    
    Casilla(float cantidad, String nombre){
        init();
        this.nombre = nombre;
        importe = cantidad;
        tipo = TipoCasilla.IMPUESTO;
    }
    
    Casilla(int numCasillaCarcel, String nombre){
        init();
        this.nombre = nombre;
        carcel = numCasillaCarcel;
        tipo = TipoCasilla.JUEZ;
    }
    
    Casilla(MazoSorpresas mazo, String nombre){
        init();
        this.nombre = nombre;
        this.mazo = mazo;
        tipo = TipoCasilla.SORPRESA;
        
    }
    
    private void init(){
        nombre = "UNDEFINED";
        carcel = 8;
        importe = (float) 0.0;
        tituloPropiedad = null;
        mazo = null;
        sorpresa = null;
        
        
    }
    
    public String getNombre(){
        return nombre;
    }
    
    private void informe(int iactual, ArrayList<Jugador> todos){
        
        Diario.instance.ocurreEvento("El jugador " + todos.get(iactual).getNombre() + " ha caido en la casilla: " + toString());
        
    }
    
    void recibeJugador(int iactual, ArrayList<Jugador> todos){

        switch (tipo) {
            case CALLE:
                System.out.println("\nRECIBE JUGADOR CALLE\n");
                recibeJugador_calle(iactual, todos);
                
                break;
            case IMPUESTO:
                recibeJugador_impuesto(iactual, todos);
                System.out.println("\nRECIBE JUGADOR IMPUESTO\n");
                break;
            case JUEZ:
                recibeJugador_juez(iactual, todos);
                System.out.println("\nRECIBE JUGADOR JUEZ\n");
                break;
            case SORPRESA:
                recibeJugador_sorpresa(iactual, todos);
                System.out.println("\nRECIBE JUGADOR SORPRESA\n");
                break;
            default:
                informe(iactual, todos);
                System.out.println("\nHACE EL INFORME\n");
                break;
        }

        
    }
    
    private void recibeJugador_calle(int iactual, ArrayList<Jugador> todos){
        
  
        
        if(jugadorCorrecto(iactual, todos)){
            
            informe(iactual, todos);
            Jugador jugador = new Jugador(todos.get(iactual));
         
            
            if(!tituloPropiedad.tienePropietario()){
                
                jugador.puedeComprarCasilla();
            }else{
                
                tituloPropiedad.tramitarAlquiler(jugador);
                      
                
            }
           
        }
       
    }
    
    
    
    private void recibeJugador_impuesto(int iactual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(iactual, todos)){
            informe(iactual, todos);
            todos.get(iactual).pagaImpuesto(importe);
        }
    }
    
    private void recibeJugador_juez(int iactual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(iactual, todos)){
            informe(iactual, todos);
            todos.get(iactual).encarcelar(carcel);
        }              
    }
    
    private void recibeJugador_sorpresa(int iactual, ArrayList<Jugador> todos){
    
        if(jugadorCorrecto(iactual,todos)){

            sorpresa = mazo.siguiente();
            informe(iactual,todos);
            sorpresa.aplicarAJugador(iactual, todos);

        }
        
    }
    
    public boolean jugadorCorrecto(int iactual, ArrayList<Jugador> todos){
        return iactual >= 0 && iactual < todos.size();
    }
    
    @Override
    public String toString(){   
        return "Casilla llamada " + nombre + ", la carcel está en la posición " + carcel + ", el importe es de " + importe + " y es de tipo " + tipo + ".";
    }
    
    TituloPropiedad getTituloPropiedad(){
        return tituloPropiedad;
    }
    
    
    
}
