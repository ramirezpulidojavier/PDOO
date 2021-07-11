/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author angelsolano
 */
public class JugadorEspeculador extends Jugador{
    
    private static final int FactorEspeculador = 2;
    private float fianza;
    
    JugadorEspeculador(Jugador jugador, float fianza){
        
        super(jugador);
        this.fianza = fianza;
        cambiarPropietario(jugador);
        super.setEspeculador(true);
            
    }
    private void cambiarPropietario(Jugador jugador){
        
    
        for (int i = 0; i < jugador.getPropiedades().size(); i++){
            
            jugador.getPropiedades().get(i).actualizaPropieatarioPorConversion(this);   
            
        }
    }
    
    @Override
    boolean encarcelar(int numCasillaCarcel){
        if (debeSerEncarcelado()){
            
                moverACasilla(numCasillaCarcel);
                encarcelado = true;
                Diario.instance.ocurreEvento("El jugador especulador " + getNombre() + " ha sido trasladado a la carcel");
        }
        else{
                
                Diario.instance.ocurreEvento("El jugador especulador " + getNombre() + " no ha sido trasladado a la carcel.");
                
        }
     
        return encarcelado;
        
    }
    
    @Override
    boolean pagaImpuesto(float cantidad){
        if (encarcelado)
            return false;
        else
            return paga(cantidad/2);
    }
    
    @Override
    boolean puedeSalirCarcelPagando(){
        return getSaldo() >= fianza;
    }
    
    @Override
    boolean salirCarcelPagando(){
        if (encarcelado && puedeSalirCarcelPagando()){
            paga(fianza);
            encarcelado = false;
            Diario.instance.ocurreEvento("El jugador especulador " + getNombre() + " sale de la carcel pagando\n");
            return true;
        }

        Diario.instance.ocurreEvento("El jugador especulador " + getNombre() + " no ha podido salir de la carcel pagando la fianza (no tiene money) \n");
        return false;
        
    }
    
    @Override
    protected boolean debeSerEncarcelado(){
        
        if (!encarcelado){
            
            if (salvoconducto == null){
                
               if (puedeSalirCarcelPagando()){
                   paga(fianza);
                   Diario.instance.ocurreEvento("\nEl jugador especulador " + nombre + " se ha librado de la carcel pagando la fianza.\n");
                   return false;
               }
               else
                   return true;
                    
                    
            }
                
            else{
                perderSalvoconducto();
                Diario.instance.ocurreEvento("El jugador " + nombre + " se libra de la carcel.");
                return false;
                
            }
                
        }
        else
            return false;
        
    }
    
    @Override
    int getCasasPorHotel(){
        return CASASPORHOTEL*2;
    }
    
    @Override
    public String toString(){       
        return super.toString()+" .Su fianza es de " + fianza + ".";
    }
    
    @Override
    int getCasasMax(){
        return CASASMAX*FactorEspeculador;
    }
    
    @Override
    int getHotelesMax(){
        return HOTELESMAX*FactorEspeculador;
    }
    
    
    
    
    
}
