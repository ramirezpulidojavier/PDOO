/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;
import java.util.Collections;
import GUI.Dado;

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
        indiceJugadorActual = Dado.getInstance().quienEmpieza(jugadores.size());
        tablero = new Tablero(1);
        mazo = new MazoSorpresas();
        inicializaTablero(mazo);
        inicializaMazoSorpresas(tablero);
        
    }
    
    
    private void inicializaTablero(MazoSorpresas mazo){
     
        tablero = new Tablero(8);
        
        TituloPropiedad propiedad1 = new TituloPropiedad("ESPAÑA", 400, (float) 1.2, 711, 1492, 600);
        CasillaDescanso casilla1 = new CasillaCalle(propiedad1.getNombre(),propiedad1);
        tablero.añadeCasilla(casilla1);
        
        TituloPropiedad propiedad2 = new TituloPropiedad("ITALIA", 450, (float) 1.2, 752, 1523, 650);
        CasillaDescanso casilla2 = new CasillaCalle(propiedad2.getNombre(),propiedad2);
        tablero.añadeCasilla(casilla2);
        
        TituloPropiedad propiedad3 = new TituloPropiedad("ALEMANIA", 700, (float) 1.2, 900, 1800, 900);
        CasillaDescanso casilla3 = new CasillaCalle(propiedad3.getNombre(),propiedad3);
        tablero.añadeCasilla(casilla3);
        
        CasillaDescanso s1 = new CasillaSorpresa("SORPRESA UNO" , mazo);
        tablero.añadeCasilla(s1);
        
        TituloPropiedad propiedad4 = new TituloPropiedad("BELGICA", 500, (float) 1.2, 810, 1570, 700);
        CasillaDescanso casilla4 = new CasillaCalle(propiedad4.getNombre(),propiedad4);
        tablero.añadeCasilla(casilla4);
        
        TituloPropiedad propiedad5 = new TituloPropiedad("RUSIA", 440, (float) 1.2, 748, 1510, 635);
        CasillaDescanso casilla5 = new CasillaCalle(propiedad5.getNombre(),propiedad5);
        tablero.añadeCasilla(casilla5);
        
        TituloPropiedad propiedad6 = new TituloPropiedad("EEUU", 720, (float) 1.2, 930, 1850, 925);
        CasillaDescanso casilla6 = new CasillaCalle(propiedad6.getNombre(),propiedad6);
        tablero.añadeCasilla(casilla6);
        
        TituloPropiedad propiedad7 = new TituloPropiedad("JAPON", 325, (float) 1.2, 610, 1320, 510);
        CasillaDescanso casilla7 = new CasillaCalle(propiedad7.getNombre(),propiedad7);
        tablero.añadeCasilla(casilla7);
        
        TituloPropiedad propiedad8 = new TituloPropiedad("COREA_DEL_NORTE", 243, (float) 1.2, 523, 1200, 401);
        CasillaDescanso casilla8 = new CasillaCalle(propiedad8.getNombre(),propiedad8);
        tablero.añadeCasilla(casilla8);
        
        CasillaDescanso s2 = new CasillaSorpresa("SORPRESA DOS" , mazo);
        tablero.añadeCasilla(s2);
        
        TituloPropiedad propiedad9 = new TituloPropiedad("GRECIA", 200, (float) 1.2, 490, 1150, 350);
        CasillaDescanso casilla9 =  new CasillaCalle(propiedad9.getNombre(),propiedad9);
        tablero.añadeCasilla(casilla9);
        
        TituloPropiedad propiedad10 = new TituloPropiedad("MADAGASCAR", 350, (float) 1.2, 620, 1330, 520);
        CasillaDescanso casilla10 = new CasillaCalle(propiedad10.getNombre(),propiedad10);
        tablero.añadeCasilla(casilla10);
        
        CasillaDescanso parking = new CasillaDescanso("PARKING");
        tablero.añadeCasilla(parking);
        
        tablero.añadeJuez();
        
        TituloPropiedad propiedad11 = new TituloPropiedad("EL CARIBE", 750, (float) 1.2, 970, 1200, 960);
        CasillaDescanso casilla11 = new CasillaCalle(propiedad11.getNombre(),propiedad11);
        tablero.añadeCasilla(casilla11);
        
        CasillaDescanso s3 = new CasillaSorpresa("SORPRESA TRES" , mazo);
        tablero.añadeCasilla(s3);
        
        CasillaDescanso impuesto = new CasillaImpuesto("IMPUESTO",(float)800.0);
        tablero.añadeCasilla(impuesto);
        
        TituloPropiedad propiedad12 = new TituloPropiedad("CHILE", 450, (float) 1.2, 758, 1200, 642);
        CasillaDescanso casilla12 = new CasillaCalle(propiedad12.getNombre(),propiedad12);
        tablero.añadeCasilla(casilla12);
        
    }
    
    private void inicializaMazoSorpresas(Tablero tablero){
        
        //Sorpresa ir_carcel = new Sorpresa(tablero, TipoSorpresa.IRCARCEL);
        Sorpresa ir_carcel = new SorpresaIrCarcel(tablero, "VAS A LA CARCEL");
        
        //Sorpresa ir_casilla = new Sorpresa(tablero, TipoSorpresa.IRCASILLA, 6, "Ve a la casilla numero 6");
        Sorpresa ir_casilla = new SorpresaIrCasilla(tablero,6, "Ve a la casilla numero 6");
        
        //Sorpresa ir_casilla2 = new Sorpresa(tablero, TipoSorpresa.IRCASILLA, 13, "Ve a la casilla numero 13");
        Sorpresa ir_casilla2 = new SorpresaIrCasilla(tablero,13,"Ve a la casilla numero 13");
        
        //Sorpresa librarte_carcel = new Sorpresa(TipoSorpresa.SALIRCARCEL, mazo);
        Sorpresa librarte_carcel = new SorpresaSalirCarcel(mazo, "SALES DE LA CARCEL");
        
        //Sorpresa paga = new Sorpresa(TipoSorpresa.PAGARCOBRAR, -150, "Pagas 150" );
        Sorpresa paga = new SorpresaPagarCobrar(-150, "Pagas 150");
        
        //Sorpresa cobra = new Sorpresa(TipoSorpresa.PAGARCOBRAR , 150, "Recibes 150");
        Sorpresa cobra = new SorpresaPagarCobrar(150, "Recibes 150");
        
        //Sorpresa paga_edificio = new Sorpresa(TipoSorpresa.PORCASAHOTEL, -40, "Costes por casas y hoteles");
        Sorpresa paga_edificio = new SopresaPorCasaHotel(-40, "Costes por casas y hoteles");
        
        //Sorpresa cobra_edifico = new Sorpresa(TipoSorpresa.PORCASAHOTEL, 40, "Beneficios por casas y hoteles");
        Sorpresa cobra_edifico = new SopresaPorCasaHotel(40, "Beneficios por casas y hoteles");
        
        //Sorpresa pagar_a_jugador = new Sorpresa( TipoSorpresa.PORJUGADOR, -20, "Pagas 20 a cada jugador");
        Sorpresa pagar_a_jugador = new SorpresaPorJugador(-20, "Pagas 20 a cada jugador");
        
        //Sorpresa cobrar_de_jugador = new Sorpresa(TipoSorpresa.PORJUGADOR, 20, "Recibes 20 de cada jugador");
        Sorpresa cobrar_de_jugador = new SorpresaPorJugador(20, "Recibes 20 de cada jugador");
        
        Sorpresa jugadorEspeculador = new SorpresaJugadorEspeculador("PASAS A SER JUGADOR ESPECULADOR",250);
        
        mazo.alMazo((jugadorEspeculador));
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
    
    public void construirImperio(){
 
        for(int i = 0; i < getJugadorActual().getPropiedades().size(); i++){
            
            getJugadorActual().duplicarSaldo();
            getJugadorActual().construirLoMaximo(i);
            
        }
        
        
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
        CasillaDescanso casilla=tablero.getCasilla(numCasillaActual);
        TituloPropiedad titulo = ((CasillaCalle)casilla).getTituloPropiedad();
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
        
    public CasillaDescanso getCasillaActual(){
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
        
        CasillaDescanso casilla = tablero.getCasilla(posicionNueva);
        
        contabilizarPasosPorSalida(jugadores.get(indiceJugadorActual));
        jugadores.get(indiceJugadorActual).moverACasilla(posicionNueva);
        
        casilla.recibeJugador(indiceJugadorActual, jugadores);
        
        contabilizarPasosPorSalida(jugadores.get(indiceJugadorActual));
        
        
        
    }
    
    
        
        
        
    }
        

    

