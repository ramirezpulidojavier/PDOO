/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import static java.lang.Float.compare;
import java.util.ArrayList;

/**
 *
 * @author angel
 */

    
public class Jugador implements Comparable<Jugador>{
    
    protected static final int CASASMAX = 4;
    protected static final int CASASPORHOTEL = 4;
    protected boolean encarcelado;
    protected static final int HOTELESMAX = 4;
    private String nombre;
    private int numCasillaActual;
    protected static final float PASOPORSALIDA = 100;
    protected static final float PRECIOLIBERTAD = 200;
    private boolean puedeComprar;
    private float saldo;
    private static final float SALDOINICIAL = 7500;
    private ArrayList<TituloPropiedad> propiedades;
    private Sorpresa salvoconducto;
    
    @Override
    public int compareTo(Jugador otro) {
        return compare(saldo, otro.saldo);
    }
    
    Jugador(String nombre){
        
        encarcelado = false;
        this.nombre = nombre;
        numCasillaActual = 0;
        puedeComprar = true;
        saldo = SALDOINICIAL;
        propiedades = new ArrayList<TituloPropiedad>();
        salvoconducto = null;
        
    }
    
    protected Jugador (Jugador jugador){
        encarcelado = jugador.encarcelado;
        nombre = jugador.nombre;
        numCasillaActual = jugador.numCasillaActual;
        puedeComprar = jugador.puedeComprar;
        saldo = jugador.saldo;
        salvoconducto = jugador.salvoconducto;
        
        propiedades = new ArrayList<>();
        
        if (!jugador.propiedades.isEmpty())
            for (int i = 0; i < jugador.propiedades.size(); i++)
                propiedades.set(i, jugador.propiedades.get(i));
        else
            propiedades = null;
        
    }
    
    protected boolean debeSerEncarcelado(){
        
        if (!encarcelado){
            if (salvoconducto == null)
                return true;
            else{
                perderSalvoconducto();
                Diario.instance.ocurreEvento("El jugador " + nombre + " se libra de la carcel.");
                return false;
                
            }
                
        }
        else
            return false;
        
    }
    
    boolean encarcelar(int numCasillaCarcel){
        if (debeSerEncarcelado()){
            moverACasilla(numCasillaCarcel);
            encarcelado = true;
            Diario.instance.ocurreEvento("El jugador " + nombre + " ha sido trasladado a la carcel.");
        }
        
        return encarcelado;
    }
    
    boolean obtenerSalvoconducto(Sorpresa sorpresa){
        
        if (!encarcelado){
            salvoconducto = sorpresa;
            return true;
        }
        else
            return false;
    }
    
    private void perderSalvoconducto(){
        salvoconducto.usada();
        salvoconducto = null;
    }
    
    boolean tieneSalvoconducto(){
        return salvoconducto != null;
    }
    
    boolean puedeComprarCasilla(){
        puedeComprar = !encarcelado;
        System.out.println("\nENTRA EN EL PUEDE COMPRAR, LO PONE A " + puedeComprar);
        return puedeComprar;
    }
    
    boolean paga(float cantidad){
        return modificarSaldo(cantidad*(-1));
    }
    
    boolean pagaImpuesto(float cantidad){
        if (encarcelado)
            return false;
        else
            return paga(cantidad);
    }
    
    boolean pagaAlquiler(float cantidad){
        if (encarcelado)
            return false;
        else
            return paga(cantidad);
    }
    
    boolean recibe(float cantidad){
        if (encarcelado)
            return false;
        else
            return modificarSaldo(cantidad);
    }
    
    boolean modificarSaldo(float cantidad){
        saldo += cantidad;
        Diario.instance.ocurreEvento("El saldo del jugador " + nombre + " ha sido modificado a " + saldo);
        return true;
    }
    
    boolean moverACasilla(int numCasilla){
        if (!encarcelado){
            numCasillaActual = numCasilla;
            Diario.instance.ocurreEvento("El jugador " + nombre + " ha sido movido a la casilla " + numCasilla);
           return true;
        }
        else
            return false;
    }
    
    private boolean puedoGastar(float precio){
        if (!encarcelado)
            return saldo >= precio;
        else
            return false;
    }
    
    boolean vender(int ip){
        
        if (!encarcelado){
            if(existeLaPropiedad(ip)){
                boolean vender = propiedades.get(ip).vender(this);
                if(vender){
                    propiedades.remove(ip);
                    Diario.instance.ocurreEvento("El jugador " + nombre + " ha vendido la propiedad " + propiedades.get(ip).getNombre());
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }
        else
            return false;
    }
    
    boolean tieneAlgoQueGestionar(){
        return propiedades != null;
    }
    
    boolean puedeSalirCarcelPagando(){
        return saldo >= PRECIOLIBERTAD;
    }
    
    boolean salirCarcelPagando(){
        if (encarcelado && puedeSalirCarcelPagando()){
            paga(PRECIOLIBERTAD);
            encarcelado = false;
            Diario.instance.ocurreEvento("El jugador " + nombre + " sale de la carcel pagando");
            return true;
        }
        else
            return false;
        
    }
    
    boolean salirCarcelTirando(){
        if(Dado.instance.salgoDeLaCarcel()){
            encarcelado = false;
            Diario.instance.ocurreEvento("El jugador " + nombre + " sale de la carcel.");
            return true;
        }   
        else
            return false;
    }
    
    boolean pasaPorSalida(){
        boolean modifica;
        modifica = modificarSaldo(PASOPORSALIDA);
        Diario.instance.ocurreEvento("El jugador " + nombre + " pasa por salida y cobra 100.");
        return modifica;
    }
    
    int cantidadCasasHoteles(){
        
        int suma = 0;
        
        for (int i = 0; i < propiedades.size(); i++)
            suma += propiedades.get(i).cantidadCasasHoteles();
        
        return suma;
    }
    
    boolean enBancarrota(){
        return saldo < 0;
    }
    
    private boolean existeLaPropiedad(int ip){
        return ip >= 0 && ip < propiedades.size();
    }
    
    private int getCasasMax(){
        return CASASMAX;
    }
    
    int getCasasPorHotel(){
        return CASASPORHOTEL;
    }
    
    private int getHotelesMax(){
        return HOTELESMAX;
    }
    
    protected String getNombre(){
        return nombre;
    }
    
    int getNumCasillaActual(){
        return numCasillaActual;
    }
    
    private float getPrecioLibertad(){
        return PRECIOLIBERTAD;
    }
    
    private float getPremioPasoPorSalida(){
        return PASOPORSALIDA;
    }
    
    public ArrayList<TituloPropiedad> getPropiedades(){
        return propiedades;
    }
    
    boolean getPuedeComprar(){
        return puedeComprar;
    }
    
    protected float getSaldo(){
        return saldo;
    }
    
    public boolean isEncarcelado(){
        return encarcelado;
    }
    
    private boolean puedoEdificarCasa(TituloPropiedad propiedad){
        
        float precio = propiedad.getPrecioEdificar();
        
        return propiedad.esEsteElPropietario(this) && propiedad.getNumCasas() < CASASPORHOTEL && this.puedoGastar(precio);
        
    }
    
    private boolean puedoEdificarHotel(TituloPropiedad propiedad){
        
        float precio = propiedad.getPrecioEdificar();
        
        return propiedad.getNumCasas() >=  CASASPORHOTEL && propiedad.getNumHoteles() < CASASPORHOTEL && this.puedoGastar(precio);
    }
    
    boolean cancelarHipoteca(int ip){
    
        boolean result=false;
        
        if(encarcelado){
            
            return result;
            
        }
        if(existeLaPropiedad(ip)){
            
            TituloPropiedad propiedad = propiedades.get(ip);  
            float cantidad = propiedad.getImporteCancelarHipoteca();
            boolean puedoGastar=puedoGastar(cantidad);
            if(puedoGastar){
                
                result=propiedad.cancelarHipoteca(this);
            
                
                if(result){
                    
                Diario.getInstance().ocurreEvento("El jugador "+nombre+ " cancela la hipoteca de la propiedad " +propiedades.get(ip).getNombre());
                    
                }
                
                
            }
            
        }
        
        
        return result;
    
    }
    
    
       boolean comprar(TituloPropiedad titulo){
           
           boolean result = false;

        if (encarcelado)
            return result;


        if (puedeComprar){

            float precio = titulo.getPrecioCompra();

            if (puedoGastar(precio)){

                result = titulo.comprar(this);

                if (result){
                    propiedades.add(titulo);
                    Diario.instance.ocurreEvento("El jugador "+nombre+ "compra la propiedad" + titulo.toString());
                }
                
                puedeComprar = false ;
                
             }

       }

        return result;
           
           
        }
    
     
    
    Boolean construirHotel (int ip){
    
    boolean result = false;
        boolean puedoEdificarHotel;
        float precio;
        int casasPorHotel;
        
        if(encarcelado)
            return result;
        
        if(existeLaPropiedad(ip)){
            
            
            TituloPropiedad propiedad;
            propiedad = propiedades.get(ip);
            
            
            puedoEdificarHotel=puedoEdificarHotel(propiedad);
            
            if(puedoEdificarHotel){
                
                result = propiedad.construirHotel(this);
                
                
                casasPorHotel=getCasasPorHotel();
                
                propiedad.derruirCasas(casasPorHotel, this);
                
            }
            
            Diario.getInstance().ocurreEvento("El jugador"+nombre+" costruye hotel en la propiedad"+ip);
        }
        
        return result;
    
    }
    
    
    Boolean construirCasa(int ip){
        
        boolean result =false, puedoEdificarCasa =false;
        
        if(encarcelado){
            return result;
        }else{
            
            boolean existe = existeLaPropiedad(ip);
        
            if(existe){
                
                TituloPropiedad propiedad=propiedades.get(ip);
                puedoEdificarCasa=puedoEdificarCasa(propiedad);
                float precio=propiedad.getPrecioEdificar();
                if(puedoGastar(precio) && propiedad.getNumCasas()<getCasasMax()){
                    
                    puedoEdificarCasa=true;
                    
                }
                if(puedoEdificarCasa){
                    
                    result=propiedad.construirCasa(this);
                    
                    if(result){
                        
                        Diario.getInstance().ocurreEvento("El jugador " +nombre+ " construye casa en la propiedad"+ propiedades.get(ip));
                        
                    }
                }
            }
        }
        
        return result;
    }
    
    protected boolean hipotecar(int ip){
        
        boolean result=false;
        if(encarcelado){
            
            return result;
            
        }
        
        if(existeLaPropiedad(ip)){
            
            TituloPropiedad propiedad = propiedades.get(ip); 
            result=propiedad.hipotecar(this);
                     
        }
        if(result){
            
            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " hipoteca la propiedad "+ propiedades.get(ip).getNombre());
        }
        
        return result;
    }
    
    
    @Override
    public String toString(){
        
        return "Jugador de nombre " + nombre + " situado en la casilla " + numCasillaActual + " con saldo " + saldo;
    }
    
    
}
