/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author angel
 */
public class CivitasJuego {
    
    private int indiceJugadorActual;
    private Tablero tablero;
    private MazoSorpresas mazo;
    private EstadosJuego estado;
    private GestorEstados gestorEstados;
    private ArrayList<Jugador> jugadores;
    
    
    public CivitasJuego(ArrayList<String> nombres){
        
        jugadores = new ArrayList<>();
        
        for (int i = 0; i < nombres.size(); i++){
            Jugador player = new Jugador(nombres.get(i));
            jugadores.add(player);
        }
        
        gestorEstados = new GestorEstados();
        estado = gestorEstados.estadoInicial();
        indiceJugadorActual = Dado.instance.quienEmpieza(jugadores.size());
        tablero = new Tablero(1);
        mazo = new MazoSorpresas();
        inicializaTablero(mazo);
        inicializaMazoSorpresas(tablero);
        
    }
    
    
    private void inicializaTablero(MazoSorpresas mazo){
     
        tablero = new Tablero(8);
        
        TituloPropiedad propiedad1 = new TituloPropiedad("ESPAÑA", 400, (float) 1.2, 711, 1492, 600);
        Casilla casilla1 = new Casilla(propiedad1);
        tablero.añadeCasilla(casilla1);
        
        TituloPropiedad propiedad2 = new TituloPropiedad("ITALIA", 450, (float) 1.2, 752, 1523, 650);
        Casilla casilla2 = new Casilla(propiedad2);
        tablero.añadeCasilla(casilla2);
        
        TituloPropiedad propiedad3 = new TituloPropiedad("ALEMANIA", 700, (float) 1.2, 900, 1800, 900);
        Casilla casilla3 = new Casilla(propiedad3);
        tablero.añadeCasilla(casilla3);
        
        Casilla s1 = new Casilla(mazo, "SORPRESA UNO");
        tablero.añadeCasilla(s1);
        
        TituloPropiedad propiedad4 = new TituloPropiedad("BELGICA", 500, (float) 1.2, 810, 1570, 700);
        Casilla casilla4 = new Casilla(propiedad4);
        tablero.añadeCasilla(casilla4);
        
        TituloPropiedad propiedad5 = new TituloPropiedad("RUSIA", 440, (float) 1.2, 748, 1510, 635);
        Casilla casilla5 = new Casilla(propiedad5);
        tablero.añadeCasilla(casilla5);
        
        TituloPropiedad propiedad6 = new TituloPropiedad("EEUU", 720, (float) 1.2, 930, 1850, 925);
        Casilla casilla6 = new Casilla(propiedad6);
        tablero.añadeCasilla(casilla6);
        
        TituloPropiedad propiedad7 = new TituloPropiedad("JAPON", 325, (float) 1.2, 610, 1320, 510);
        Casilla casilla7 = new Casilla(propiedad7);
        tablero.añadeCasilla(casilla7);
        
        TituloPropiedad propiedad8 = new TituloPropiedad("COREA_DEL_NORTE", 243, (float) 1.2, 523, 1200, 401);
        Casilla casilla8 = new Casilla(propiedad8);
        tablero.añadeCasilla(casilla8);
        
        Casilla s2 = new Casilla(mazo, "SORPRESA DOS");
        tablero.añadeCasilla(s2);
        
        TituloPropiedad propiedad9 = new TituloPropiedad("GRECIA", 200, (float) 1.2, 490, 1150, 350);
        Casilla casilla9 = new Casilla(propiedad9);
        tablero.añadeCasilla(casilla9);
        
        TituloPropiedad propiedad10 = new TituloPropiedad("MADAGASCAR", 350, (float) 1.2, 620, 1330, 520);
        Casilla casilla10 = new Casilla(propiedad10);
        tablero.añadeCasilla(casilla10);
        
        Casilla parking = new Casilla("PARKING");
        tablero.añadeCasilla(parking);
        
        tablero.añadeJuez();
        
        TituloPropiedad propiedad11 = new TituloPropiedad("EL CARIBE", 750, (float) 1.2, 970, 1200, 960);
        Casilla casilla11 = new Casilla(propiedad11);
        tablero.añadeCasilla(casilla11);
        
        Casilla s3 = new Casilla(mazo, "SORPRESA TRES");
        tablero.añadeCasilla(s3);
        
        Casilla impuesto = new Casilla((float)800.0, "IMPUESTO");
        tablero.añadeCasilla(impuesto);
        
        TituloPropiedad propiedad12 = new TituloPropiedad("CHILE", 450, (float) 1.2, 758, 1200, 642);
        Casilla casilla12 = new Casilla(propiedad12);
        tablero.añadeCasilla(casilla12);
        
    }
    
    private void inicializaMazoSorpresas(Tablero tablero){
        
        Sorpresa ir_carcel = new Sorpresa(tablero, TipoSorpresa.IRCARCEL);
        Sorpresa ir_casilla = new Sorpresa(tablero, TipoSorpresa.IRCASILLA, 6, "Ve a la casilla numero 6");
        Sorpresa ir_casilla2 = new Sorpresa(tablero, TipoSorpresa.IRCASILLA, 13, "Ve a la casilla numero 13");
        Sorpresa librarte_carcel = new Sorpresa(TipoSorpresa.SALIRCARCEL, mazo);
        Sorpresa paga = new Sorpresa(TipoSorpresa.PAGARCOBRAR, -150, "Pagas 150" );
        Sorpresa cobra = new Sorpresa(TipoSorpresa.PAGARCOBRAR , 150, "Recibes 150");
        Sorpresa paga_edificio = new Sorpresa(TipoSorpresa.PORCASAHOTEL, -40, "Costes por casas y hoteles");
        Sorpresa cobra_edifico = new Sorpresa(TipoSorpresa.PORCASAHOTEL, 40, "Beneficios por casas y hoteles");
        Sorpresa pagar_a_jugador = new Sorpresa( TipoSorpresa.PORJUGADOR, -20, "Pagas 20 a cada jugador");
        Sorpresa cobrar_de_jugador = new Sorpresa(TipoSorpresa.PORJUGADOR, 20, "Recibes 20 de cada jugador");
        mazo.alMazo(ir_carcel);
        mazo.alMazo(ir_casilla);
        mazo.alMazo(ir_casilla2);
        mazo.alMazo(librarte_carcel);
        mazo.alMazo(paga);
        mazo.alMazo(cobra);
        mazo.alMazo(paga_edificio);
        mazo.alMazo(cobra_edifico);
        mazo.alMazo(pagar_a_jugador);
        mazo.alMazo(cobrar_de_jugador);

    }
    
    private void contabilizarPasosPorSalida(Jugador jugadorActual){

        while (tablero.getPorSalida() > 0){
            jugadorActual.pasaPorSalida();
        }
        
    }
    
    private void pasarTurno(){
        
        indiceJugadorActual = (indiceJugadorActual+1)%jugadores.size();
        
    }
    
    public void siguientePasoCompletado(OperacionesJuego operacion){
        estado = gestorEstados.siguienteEstado(jugadores.get(indiceJugadorActual), estado, operacion);
    }
    
    public boolean construirCasa(int ip){
        return jugadores.get(indiceJugadorActual).construirCasa(ip);
    }
    
    public boolean construirHotel(int ip){
        return jugadores.get(indiceJugadorActual).construirHotel(ip);
    }
    
    
    
    public boolean hipotecar(int ip){
        return jugadores.get(indiceJugadorActual).hipotecar(ip);
    }
    
    public boolean cancelarHipoteca(int ip){
        return jugadores.get(indiceJugadorActual).cancelarHipoteca(ip);
    }
  
    public boolean comprar(){
        
        Jugador jugadorActual=jugadores.get(indiceJugadorActual);
        int numCasillaActual= jugadorActual.getNumCasillaActual();
        Casilla casilla=tablero.getCasilla(numCasillaActual);
        TituloPropiedad titulo = casilla.getTituloPropiedad();
        boolean res = jugadorActual.comprar(titulo);
        return res;
    
    }
    
    public OperacionesJuego siguientePaso(){
    
        Jugador jugadorActual= jugadores.get(indiceJugadorActual);
        OperacionesJuego operacion= gestorEstados.operacionesPermitidas(jugadorActual, estado);
        if(operacion==OperacionesJuego.PASAR_TURNO){
            
            pasarTurno();
            siguientePasoCompletado(operacion);
        
        }else if(operacion==OperacionesJuego.AVANZAR){
            
            avanzaJugador();
            siguientePasoCompletado(operacion);
            
        }
        
        return operacion;
    }

    
    public boolean salirCarcelPagando(){
        return jugadores.get(indiceJugadorActual).salirCarcelPagando();
    }
    
    public boolean salirCarcelTirando(){
        return jugadores.get(indiceJugadorActual).salirCarcelTirando();
    }
    
    public boolean finalDelJuego(){
        
       for (int i = 0; i < jugadores.size(); i++){
           if(jugadores.get(i).enBancarrota())
               return true;
       }
       
       return false;
        
    }
    
    public boolean vender(int ip){
       return jugadores.get(indiceJugadorActual).vender(ip);
    }
    
    public ArrayList<Jugador> ranking(){
        
        Collections.sort(jugadores);
        
        System.out.println("\nRanking de Jugadores!!!\n");
        
        for (int i = 0; i < jugadores.size();i++){
            System.out.println(jugadores.get(i).toString() + "\n");
        }
        
        return jugadores;
        
    }
        
    public Casilla getCasillaActual(){
        return tablero.getCasilla(jugadores.get(indiceJugadorActual).getNumCasillaActual());
    }
    
    public Jugador getJugadorActual(){
        return jugadores.get(indiceJugadorActual);
    }
    
    public String infoJugadorTexto(){
        
        Jugador player = new Jugador(jugadores.get(indiceJugadorActual));
        return player.toString();
        
    }  
    /*
    private void avanzaJugador(){
        
        Jugador jugadorActual;
        int posicionActual;
        int tirada;
        int posicionNueva;
        Casilla casilla;
        
        jugadorActual = jugadores.get(indiceJugadorActual);
        
        posicionActual = jugadores.get(indiceJugadorActual).getNumCasillaActual();
        
        tirada = Dado.getInstance().tirar();
        
        
        posicionNueva = tablero.nuevaPosicion(posicionActual, tirada);
        
        casilla = tablero.getCasilla(posicionNueva);
        
        contabilizarPasosPorSalida(jugadorActual); BIEN
        jugadorActual.moverACasilla(posicionNueva); BIEN
        
        casilla.recibeJugador(indiceJugadorActual, jugadores);
        
        contabilizarPasosPorSalida(jugadorActual);
        
        
        
    }
    */
    private void avanzaJugador(){
        
        int posicionActual = jugadores.get(indiceJugadorActual).getNumCasillaActual();
        
        int tirada = Dado.getInstance().tirar();
        
        int posicionNueva = tablero.nuevaPosicion(posicionActual, tirada);
        
        Casilla casilla = tablero.getCasilla(posicionNueva);
        
        contabilizarPasosPorSalida(jugadores.get(indiceJugadorActual));
        jugadores.get(indiceJugadorActual).moverACasilla(posicionNueva);
        
        casilla.recibeJugador(indiceJugadorActual, jugadores);
        
        contabilizarPasosPorSalida(jugadores.get(indiceJugadorActual));
        
        
        
    }
    
    
        
        
        
    }
        

    

