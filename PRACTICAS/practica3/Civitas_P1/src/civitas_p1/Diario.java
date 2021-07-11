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

public class Diario {
  public static final Diario instance = new Diario();
  
  private ArrayList<String> eventos;
  
  static public Diario getInstance() {
    return instance;
  }
  
  Diario () {
    eventos = new ArrayList<>();
  }
  
  void ocurreEvento(String e) {
    eventos.add (e);
  }
  
  public boolean eventosPendientes () {
    return !eventos.isEmpty();
  }
  
  public String leerEvento () {
    String salida = "";
    if (!eventos.isEmpty()) {
      salida = eventos.remove(0);
    }
    return salida;
  }
}


//Diario.getInstance() Así se obtiene la única instancia del diario
