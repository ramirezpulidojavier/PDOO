package civitas_p1;
import civitas_p1.CivitasJuego;
import civitas_p1.Diario;
import civitas_p1.OperacionesJuego;
import civitas_p1.SalidasCarcel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import civitas_p1.Casilla;
import civitas_p1.Jugador;
import civitas_p1.TituloPropiedad;

class VistaTextual {
  
  CivitasJuego juegoModel;
  int iGestion=-1;
  int iPropiedad=-1;
  private static String separador = "=====================";
  
  private Scanner in;
  
  VistaTextual () {
    in = new Scanner (System.in);
  }
  
  void mostrarEstado(String estado) {
    System.out.println (estado);
  }
              
  void pausa() {
    System.out.print ("Pulsa una tecla");
    in.nextLine();
  }

  int leeEntero (int max, String msg1, String msg2) {
    Boolean ok;
    String cadena;
    int numero = -1;
    do {
      System.out.print (msg1);
      cadena = in.nextLine();
      try {  
        numero = Integer.parseInt(cadena);
        ok = true;
      } catch (NumberFormatException e) { // No se ha introducido un entero
        System.out.println (msg2);
        ok = false;  
      }
      if (ok && (numero < 0 || numero >= max)) {
        System.out.println (msg2);
        ok = false;
      }
    } while (!ok);

    return numero;
  }

  int menu (String titulo, ArrayList<String> lista) {
    String tab = "  ";
    int opcion;
    System.out.println (titulo);
    for (int i = 0; i < lista.size(); i++) {
      System.out.println (tab+i+"-"+lista.get(i));
    }

    opcion = leeEntero(lista.size(),
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo");
    return opcion;
  }

  SalidasCarcel salirCarcel() {
    int opcion = menu ("Elige la forma para intentar salir de la carcel",
      new ArrayList<> (Arrays.asList("Pagando","Tirando el dado")));
    return (SalidasCarcel.values()[opcion]);
  }

  Respuestas comprar() {
  
  int opcion = menu ("¿Deseas comprar la calle a la que has llegado?",
      new ArrayList<> (Arrays.asList("NO","SI")));
  return (Respuestas.values()[opcion]);
  }

  void gestionar () {

    String cabecera = "¿Que gestion desea realizar?";
    
    ArrayList<String> opciones = new ArrayList<>();
    opciones.add("VENDER");
    opciones.add("HIPOTECAR");
    opciones.add("CANCELAR_HIPOTECA");
    opciones.add("CONSTRUIR_CASA");
    opciones.add("CONSTRUIR_HOTE");
    opciones.add("TERMINAR");

    int elegido = menu(cabecera, opciones);
    
    switch (elegido){
        case 0: iGestion = 0;
        break;
        case 1: iGestion = 1;
        break;
        case 2: iGestion = 2;
        break;
        case 3: iGestion = 3;
        break;
        case 4: iGestion = 4;
        break;
        case 5: iGestion = 5;
        break;
    }
    
    if (iGestion != 5){
        Scanner sc = new Scanner(System.in);
        System.out.println("Elige el indice de la propiedad que quieres gestionar: ");
        int npropiedad = sc.nextInt();
        while (npropiedad < 0 || npropiedad > juegoModel.getJugadorActual().getPropiedades().size()){
            System.out.println("\nHay " + juegoModel.getJugadorActual().getPropiedades().size() + " propiedades. \n");
            npropiedad = sc.nextInt();
            System.out.println("\nValor de npropiedad " + npropiedad + ". \n");
        }
        iPropiedad = npropiedad;
    }
    
    
  }

/*
  
  void gestionar () {

      int opcion = menu("¿Que gestión inmobiliaria desea hacer?",
        new ArrayList<> (Arrays.asList("VENDER","HIPOTECAR","CANCELAR HIPOTECA",
        "CONSTRUIR CASA","CONSTRUIR HOTEL", "TERMINAR")));

      iGestion = opcion;

      if(juegoModel.getJugadorActual().tieneAlgoQueGestionar() && opcion!=5){

          int indice = menu ("¿Sobre qué propiedad desea realiza la gestion?",
          new ArrayList<>(Arrays.asList("0 - "+juegoModel.getJugadorActual().getPropiedades().size())));

          iPropiedad = indice;

      }else{
          System.out.println("El jugador actual no tiene nada que gestionar");
      }


  }

*/
  
  public int getGestion(){return iGestion;}
  
  public int getPropiedad(){return iPropiedad;}
    

  void mostrarSiguienteOperacion(OperacionesJuego operacion) {
  
  System.out.println ("La siguiente operacion que se va a realizar es: " + operacion.name());
      
  }


  void mostrarEventos() {  
      
  System.out.println("\nLos eventos pendientes son: ");
  while(Diario.instance.eventosPendientes()){
      
      System.out.println(Diario.instance.leerEvento());
      
  }
         
  }
  
  public void setCivitasJuego(CivitasJuego civitas){ 
        juegoModel=civitas;
        this.actualizarVista();

    }
  
  void actualizarVista(){         
      
      System.out.println(juegoModel.infoJugadorTexto());
      
  } 
}
