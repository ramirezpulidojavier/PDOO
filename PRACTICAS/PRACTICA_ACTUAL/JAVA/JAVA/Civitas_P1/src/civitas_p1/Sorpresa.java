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
abstract public class Sorpresa {
    
    private String texto;
    
    Sorpresa(String texto){
        this.texto = texto;
    }
    
    /*
    Sorpresa(Tablero tablero,  TipoSorpresa tipo){
        init();
        this.tablero = tablero;
        this.tipo = tipo;
	texto = "UNDEFINED";
    }
    
    Sorpresa(Tablero tablero,  TipoSorpresa tipo, int valor, String texto){
        init();
        this.tablero = tablero;
        this.tipo = tipo; 
        this.valor = valor;
        this.texto = texto;
    }
    
    Sorpresa(TipoSorpresa tipo,  int valor, String texto ){
        init();
        this.tipo = tipo; 
        this.valor = valor;
        this.texto = texto;
    }
    
    Sorpresa(TipoSorpresa tipo, MazoSorpresas mazo){
        init();
        this.tipo = tipo; 
        this.mazo = mazo;
	texto = "UNDEFINED";
    }
    
    private void init(){
        valor = -1;
        mazo = null;
        tablero = null;
    }
*/
    
    public Boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos){
        if (actual >= 0 && actual < todos.size())
            return true;
        else
            return false;
    }
    
    public void informe(int actual, ArrayList<Jugador> todos){
        Diario.instance.ocurreEvento("Se esta aplicando una sorpresa al Jugador " + todos.get(actual).getNombre());               
    }
    
    abstract void aplicarAJugador(int actual, ArrayList<Jugador> todos);
        /*
        if(tipo==TipoSorpresa.IRCARCEL){
            aplicarAJugador_irCarcel(actual,todos);
        }
        else if(tipo==TipoSorpresa.IRCASILLA){
            aplicarAJugador_irACasilla(actual,todos);
        }
        else if(tipo==TipoSorpresa.PAGARCOBRAR){
            aplicarAJugador_pagarCobrar(actual,todos);
        }
        else if(tipo==TipoSorpresa.PORCASAHOTEL){
            aplicarAJugador_porCasaHotel(actual,todos);
        }
        else if(tipo==TipoSorpresa.PORJUGADOR){
            aplicarAJugador_porJugador(actual,todos);
        }
        else if(tipo==TipoSorpresa.SALIRCARCEL){
            aplicarAJugador_salirCarcel(actual,todos);
        }
    
    
    
    private void aplicarAJugador_irCarcel(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).encarcelar(tablero.getCarcel());        
        }
    }
    
    private void aplicarAJugador_irACasilla(int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            int casillaActual = todos.get(actual).getNumCasillaActual();
            int tirada = tablero.calcularTirada(casillaActual, valor);
            int new_pos = tablero.nuevaPosicion(casillaActual, tirada);
            todos.get(actual).moverACasilla(new_pos);
            tablero.getCasilla(new_pos).recibeJugador(actual,todos);
        }
    }
    
    private void aplicarAJugador_pagarCobrar (int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).modificarSaldo(valor);
        }
    }

    private void aplicarAJugador_porCasaHotel (int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).modificarSaldo(valor*(todos.get(actual).cantidadCasasHoteles()));
            int x = 0;
        }
    }

    private void aplicarAJugador_porJugador (int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            Sorpresa p1 = new SorpresaPagarCobrar(mazo, tablero, valor*(-1), "PagarCobrar");
        
            for (int i = 0; i < todos.size(); i++)
                if (i != actual)
                    p1.aplicarAJugador_pagarCobrar(i,todos);
        
            Sorpresa p2 = new SorpresaPagarCobrar(mazo, tablero, valor*(todos.size() - 1), "PagarCobrar");
            p2.aplicarAJugador_pagarCobrar(actual,todos);
        }
    }
         
    private void aplicarAJugador_salirCarcel (int actual, ArrayList<Jugador> todos){
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            Boolean tienenCarcel = false;
            for (int i = 0; i < todos.size() && !tienenCarcel; i++){
                if (i!=actual)
                    if (todos.get(i).tieneSalvoconducto())
                        tienenCarcel = true;
            }
            
            if(!tienenCarcel){
                    this.texto = "SALVOCONDUCTO";
                    todos.get(actual).obtenerSalvoconducto(this);
                    salirDelMazo();
            }
            
            
        }
    }
*/
    
    
    @Override
    public String toString(){
        return texto;
    }
    
    
}   
