/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

/**
 *
 * @author xaviv
 */
public class Test_P1 {
    public static void main(String[] args) {
        
        
        int contador0, contador1, contador2, contador3, x;
        
        
        contador0 = contador1 = contador2 = contador3 = 0;
          
        for (int i = 0; i < 100; i++){
            
            x = Dado.getInstance().quienEmpieza(4);
            
            if (x == 0){
                contador0 ++;
            }
            if (x == 1){
                contador1 ++;
            }
            if (x == 2){
                contador2 ++;
            }
            if (x == 3){
                contador3 ++;
            }
            
        }
      
        System.out.println("\nContador 0: " + contador0 + "\nContador 1: " + contador1 + "\nContador 2: " + contador2 + "\nContador 3: " + contador3);
     
        
        for (int i = 0; i < 20; i++){
            
            if (Dado.getInstance().salgoDeLaCarcel())
                System.out.println( "\n" + Dado.getInstance().getUltimoResultado());
            else
                System.out.println( "\nNo salgo");
            
            
                
        }
        
        
        MazoSorpresas españa = new MazoSorpresas();
        Sorpresa s1 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, ), s2 = new Sorpresa(TipoSorpresa.PORJUGADOR);
        
        españa.alMazo(s1);
        españa.alMazo(s2);
        
        System.out.println( "\n" + españa.getSorpresa(0).getTipo() + "\n" + españa.getSorpresa(1).getTipo());
        
        españa.inhabilitarCartaEspecial(s2);
        
        españa.habilitarCartaEspecial(s2);
        
        System.out.println( "\n" + Diario.getInstance().leerEvento() + "\n" + Diario.getInstance().leerEvento());
        
        if (Diario.getInstance().eventosPendientes())
            System.out.println("\n ohhhh");
        else
            System.out.println("\n ahhhh");
        
        
        Tablero monotu = new Tablero(6);
        
        for(int i = 0; i < 12; i++){
            
            if (i < 5){
                Casilla s = new Casilla("Calle", TipoCasilla.CALLE);
                monotu.añadeCasilla(s);
            }
            else if (i == 5){
                Casilla s = new Casilla("Sorpresa", TipoCasilla.SORPRESA);
                monotu.añadeCasilla(s);
            }
            else if (i == 6){
                Casilla s = new Casilla("Aparcamiento", TipoCasilla.DESCANSO);
                monotu.añadeCasilla(s);
            }
            else if (i == 7){
                monotu.añadeJuez();
            }
            else if (i == 8){
                Casilla s = new Casilla("Paga", TipoCasilla.IMPUESTO);
                monotu.añadeCasilla(s);
            }
            else{
                Casilla s = new Casilla("Calle", TipoCasilla.CALLE);
                monotu.añadeCasilla(s);
            }
        }
        
        
        int cont = 0, pos_actual = 0;
       
        
        
        while (cont < monotu.getSize()){
            
            System.out.println("\n" + Dado.getInstance().getUltimoResultado());
            
            System.out.println("\n" + monotu.getCasilla(pos_actual).getNombre());
            
            pos_actual = monotu.nuevaPosicion(pos_actual, Dado.getInstance().tirar());
            
            cont ++;    
   
        }
               
        System.out.println("\n" + monotu.getPorSalida());
    }
}
