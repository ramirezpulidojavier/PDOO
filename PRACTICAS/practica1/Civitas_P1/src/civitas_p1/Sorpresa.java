/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;


import java.util.ArrayList;

/**
 *
 * @author angel
 */
public class Sorpresa {
    private TipoSorpresa tipo;
    private String texto;
    private int valor;
    private MazoSorpresas mazo;
    private Tablero tablero;
    
    
    Sorpresa(TipoSorpresa _tipo, Tablero tab){
        init();
        tipo = _tipo;
        tablero =tab;
    }
    Sorpresa(TipoSorpresa _tipo, MazoSorpresas maz){
        init();
        tipo = _tipo;
        mazo=maz;
        
    }
    Sorpresa(TipoSorpresa _tipo, Tablero tab, int val, String text){
        init();
        tipo = _tipo;
        tablero =tab;
        valor=val;
        texto=text;
    }
    Sorpresa(TipoSorpresa _tipo, int val, String text){
        init();
        tipo = _tipo;
        valor=val;
        texto=text;
    }
    
    private void init(){
        
        valor=-1;
        mazo=null;
        tablero=null;
        
        
    }
    
    TipoSorpresa getTipo(){
        return tipo;
    }
    
    public boolean jugadorCorrecto(int actual, ArrayList<Jugador>todos){
        
        if(actual>=0 && actual<todos.size()){
            
            return true;
            
        }
        
        return false;
    }
    
    private void informe(int actual, ArrayList<Jugador>todos){
        
        Diario.getInstance().ocurreEvento("Se está aplicando una sorpresa a " + todos.get(actual).getNombre());
        
    }
    void aplicarAJugador(int actual, ArrayList<Jugador> todos){
        
        if(tipo==TipoSorpresa.IRCARCEL){
            
            aplicarAJugador_irCarcel(actual,todos);
            
        }else if(tipo==TipoSorpresa.IRCASILLA){
            
            aplicarAJugador_irACasilla(actual,todos);
            
        }else if(tipo==TipoSorpresa.PAGARCOBRAR){
            
            aplicarAJugador_pagarCobrar(actual,todos);
            
        }else if(tipo==TipoSorpresa.PORCASAHOTEL){
            
            aplicarAJugador_porCasaHotel(actual,todos);
            
        }else if(tipo==TipoSorpresa.PORJUGADOR){
            
            aplicarAJugador_porJugador(actual,todos);
            
        }else if(tipo==TipoSorpresa.SALIRCARCEL){
            
            aplicarAJugador_salirCarcel(actual,todos);
            
        }
        
    }
    private void aplicarAJugador_irCarcel(int actual, ArrayList<Jugador>todos){
        
        if (jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            todos.get(actual).encarcelar(tablero.getCarcel());
            
        }
        
    }
    private void aplicarAJugador_irACasilla(int actual, ArrayList<Jugador>todos){
        
        if (jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            int act = todos.get(actual).getNumCasillaActual();
            int tirada = tablero.calcularTirada(act, valor);
            int nueva = tablero.nuevaPosicion(act, tirada);
            todos.get(actual).moverACasilla(nueva);
            tablero.getCasilla(nueva).recibeJugador(actual,todos);
        }
        
    }
    
    private void aplicarAJugador_pagarCobrar(int actual, ArrayList<Jugador> todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            todos.get(actual).modificarSaldo(valor);
            
        }
        
    }
    private void aplicarAJugador_porCasaHotel(int actual, ArrayList<Jugador> todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            todos.get(actual).modificarSaldo(valor*todos.get(actual).cantidadCasasHoteles());
            
        }
        
    }
    private void aplicarAJugador_porJugador(int actual, ArrayList<Jugador> todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            Sorpresa s1 = new Sorpresa(TipoSorpresa.PAGARCOBRAR,valor*(-1),"PagarCobrar");
            for(int i = 0 ; i < todos.size();i++){
                
                if(i!=actual){
                    s1.aplicarAJugador_pagarCobrar(i, todos);
                }
                
            }
            Sorpresa s2=new Sorpresa(TipoSorpresa.PAGARCOBRAR,valor*(todos.size()-1),"PagarCobrar");
            s2.aplicarAJugador_pagarCobrar(actual, todos);
        }
        
    }
    private void aplicarAJugador_salirCarcel(int actual, ArrayList<Jugador> todos){
        
        if(jugadorCorrecto(actual,todos)){
            
            informe(actual,todos);
            boolean tiene=false;
            for(int i = 0; i < todos.size() && !tiene ;i++){
                
                if(todos.get(i).tieneSalvoconducto()){
                    
                    tiene=true;
                    
                }
                
            }
            if(!tiene){
                
                todos.get(actual).obtenerSalvoconducto(this);
                salirDelMazo();
                
            }
            
        }
        
    }
    void salirDelMazo(){
        
        if(tipo==TipoSorpresa.SALIRCARCEL){
            
            mazo.inhabilitarCartaEspecial(this);
            
        }
        
    }
    void usada(){
        
        if(tipo==TipoSorpresa.SALIRCARCEL){
            
            mazo.habilitarCartaEspecial(this);
            
        }
        
    }
    public String toString(){
        
        return texto;
        
    }    
    
}
