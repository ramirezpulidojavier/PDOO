/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;

/**
 *
 * @author xaviv
 */
public class CivitasJuego {
    
    private int indiceJugadorActual;
    private Tablero tablero;
    private MazoSorpresas mazo;
    private EstadosJuego estado;
    private GestorEstados gestorEstados;
    private ArrayList<Jugador> jugadores;
    
    public CivitasJuego(ArrayList<String> nombres){
        
        for(int i = 0; i< nombres.size();++i){
            
            Jugador jug= new Jugador(nombres.get(i));
            jugadores.add(jug);
            
        }
        gestorEstados = new GestorEstados();
        estado = gestorEstados.estadoInicial();
        indiceJugadorActual= Dado.getInstance().quienEmpieza(jugadores.size());
        mazo = new MazoSorpresas();
        
        
    }
    public boolean cancelarHipoteca(int ip){
        
        return jugadores.get(indiceJugadorActual).cancelarHipoteca(ip);
        
    }
    public boolean construirCasa(int ip){
        
        return jugadores.get(indiceJugadorActual).construirCasa(ip);
        
    }
    public boolean construirHotel(int ip){
        
        return jugadores.get(indiceJugadorActual).construirHotel(ip);
        
    }
    private void contabilizarPasosPorSalida(Jugador jugadorActual){
        
        int veces=tablero.getPorSalida();
        
        while(veces>0){
            jugadorActual.pasaPorSalida();
            --veces;
        }
        
    }
    public boolean finalDelJuego(){
        
        boolean fin = false;
        for(int i = 0; i < jugadores.size() && !fin;++i){
            
            if(jugadores.get(i).enBancarrota())
                fin=true;
        }
        return fin;
    }
    public Casilla getCasillaActual(){
        
        return tablero.getCasilla(jugadores.get(indiceJugadorActual).getNumCasillaActual());
        
    }
    public Jugador getJugadorActual(){
        
        return jugadores.get(indiceJugadorActual);
        
    }
    public boolean hipotecar(int ip){
        
        return jugadores.get(indiceJugadorActual).hipotecar(ip);
        
    }
    public String infoJugadorTexto(){
        
        return jugadores.get(indiceJugadorActual).toString();
        
    }
    private void inicializarMazoSorpresas(MazoSorpresas mazo){
        
        for(int i = 0; i < mazo.getsize(); ++i){
            
            this.mazo.alMazo(mazo.getSorpresa(i));
            
        }
                
    }
    private void inicializarTablero(Tablero tablero){
        
        this.tablero = new Tablero(tablero.getCarcel());
        int cont=0, i = 0;
        while(cont<2){
            
            Casilla cas = tablero.getCasilla(i);
            if(cas.getNombre()=="Salida" || cas.getNombre()=="salida"){
                cont++;
            }
            if(cont<2)
                this.tablero.añadeCasilla(cas);
            ++i;
        }
        
    }
    private void pasarTurno(){
        
        indiceJugadorActual = (indiceJugadorActual+1)%jugadores.size();
        
    }
    private ArrayList<Jugador> ranking(){
        int maximo, posicion=0;
        ArrayList<Jugador> ganadores= new ArrayList<Jugador>(jugadores.size());
        ArrayList<Jugador> auxiliar= new ArrayList<Jugador>(jugadores.size());
        for(int i = 0; i< jugadores.size();++i){
            
            Jugador jug= new Jugador(jugadores.get(i));
            ganadores.add(jug);
            
        }
        while(ganadores.size()>0){
            maximo=-3;
            for (int i = 0; i < ganadores.size() - 1; i++) {
                int cont = 0;
                for (int j = 0; j < ganadores.size() - i - 1; j++) {
                    cont = cont + ganadores.get(i).compareTo(ganadores.get(j));
                }
                if(cont>=maximo){

                    maximo=cont;
                    posicion=i;

                }
            }
            auxiliar.add(ganadores.get(posicion));
            ganadores.remove(ganadores.get(posicion));
        }
        
        return auxiliar;
    }
    public boolean salirCarcelPagando(){
        
        return jugadores.get(indiceJugadorActual).salirCarcelPagando();
        
    }
    public boolean salirCarcelTirando(){
        
        return jugadores.get(indiceJugadorActual).salirCarcelTirando();
        
    }
    public void siguientePasoCompletado(OperacionesJuego operacion){
        
        estado=gestorEstados.siguienteEstado(jugadores.get(indiceJugadorActual), estado, operacion);
        
    }
    public boolean vender(int ip){
        
        return jugadores.get(indiceJugadorActual).vender(ip);
        
    }
}
