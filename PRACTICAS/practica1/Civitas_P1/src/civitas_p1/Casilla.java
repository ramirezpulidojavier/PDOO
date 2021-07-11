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
public class Casilla {
    
    private String nombre;
    private TipoCasilla tipo;
    private static int carcel;
    private float importe;
    private TituloPropiedad tituloPropiedad; //solo para CALLE
    private MazoSorpresas mazo;
    private Sorpresa sorpresa;
    
    Casilla(String nombre , TipoCasilla tipo){
        init();
        this.nombre=nombre;
        this.tipo=tipo;
    }
    Casilla(TituloPropiedad titulo){
        init();
        tituloPropiedad=titulo;
    }
    Casilla(String name){
        init();
        this.nombre = name;
    }
    Casilla(float cantidad, String nombre){
        init();
        this.nombre = nombre;
        importe=cantidad;
    }
    Casilla(int numCasillaCarcel, String nombre){
        init();
        this.nombre=nombre;
        carcel=numCasillaCarcel;
    }
    Casilla(MazoSorpresas mazo,String nombre){
        init();
        this.mazo=mazo;
        this.nombre=nombre;
        
    }
    private void init(){
        
        nombre = "Calle";
        tipo = TipoCasilla.CALLE;
        carcel = 0;
        importe = (float) 0.0;
        TituloPropiedad tl;
        tl = new TituloPropiedad("Propiedad vacia",(float)0.0,0,(float)0.0,(float)0.0,(float)0.0);
        tituloPropiedad = tl ;
        MazoSorpresas maz = null;
        maz.init();
        mazo = maz;
        Sorpresa sor;
        sor = new Sorpresa(TipoSorpresa.IRCASILLA,mazo);
        sorpresa = sor;
        
    }
    private void informe(int actual, ArrayList<Jugador>todos){
        
        Diario.getInstance().ocurreEvento("El jugador que ha caido en la casilla es " + todos.get(actual).getNombre());
        toString();
        
    }
    public boolean jugadorCorrecto(int actual, ArrayList<Jugador>todos){
        
        if(actual>=0 && actual<todos.size()){
            
            return true;
            
        }
        
        return false;
    }
    private void recibeJugador_impuesto(int actual,ArrayList<Jugador>todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            todos.get(actual).pagaImpuesto(importe);
            
        }
        
    }
    private void recibeJugador_juez(int actual, ArrayList<Jugador>todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            todos.get(actual).encarcelar(carcel);
            
        }
        
    }
    public String toString(){
        
        return "Esta casilla se llama" +nombre+ ", es de tipo" + tipo + ", la carcel se encuentra en la posicion " +carcel+ ", el importe a pagar es de " +importe;
        
    }
    public String getNombre(){
        return this.nombre;
    }
    
    TituloPropiedad getTituloPropiedad(){
        
        return tituloPropiedad;
        
    }
    
}
