 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;


import static java.lang.Double.compare;
import java.util.ArrayList;

/**
 *
 * @author xaviv
 */
public class Jugador implements Comparable<Jugador>{
    
    private static final int CasasMax=4;
    private static final int CasasPorHotel=4;
    private static final int HotelesMax=4;
    private static final float PasoPorSalida=1000;
    private static final float PrecioLibertad=200;
    private static final float SaldoInicial =7500;
    private boolean encarcelado;
    private String nombre;
    private int numCasillaActual;
    private boolean puedeComprar;
    private float saldo;
    private ArrayList<TituloPropiedad> propiedades;
    private Sorpresa salvoconducto;
  
    
    Jugador(String nombre){
        
        this.nombre=nombre;
        encarcelado=false;
        numCasillaActual=0;
        puedeComprar=false;
        saldo=0;
        propiedades=null;
        salvoconducto= new Sorpresa(TipoSorpresa.SALIRCARCEL,0,"Salvoconducto");
    }
    protected Jugador(Jugador otro){
        
        encarcelado=otro.isEncarcelado();
        nombre=otro.getNombre();
        numCasillaActual=otro.getNumCasillaActual();
        puedeComprar=otro.puedeComprarCasilla();
        saldo=otro.getSaldo();
        propiedades=otro.getPropiedades();
        salvoconducto= new Sorpresa(TipoSorpresa.SALIRCARCEL,0,"Salvoconducto");
        
    
        
    }
    protected boolean debeSerEncarcelado(){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            if(!tieneSalvoconducto()){
                
                return true;
                
            }else{
                
                perderSalvoconducto();
                Diario.getInstance().ocurreEvento("El jugador" +nombre+ "ha gastado el salvoconducto para salir de la carcel");
                return false;
                
            }
            
        }
        
    }
    boolean encarcelar(int numCasillaCarcel){
        
        if(debeSerEncarcelado()){
            moverACasilla(numCasillaCarcel);
            encarcelado=true;
            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " es encarcelado");
        }
        return encarcelado;
    }
    private void perderSalvoconducto(){
        
        salvoconducto.usada();
        salvoconducto = null;
        
    }
    boolean obtenerSalvoconducto(Sorpresa s){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            salvoconducto=s;
            return true;
            
        }
        
    }
    boolean tieneSalvoconducto(){
        
        if(salvoconducto==null){
            
            return false;
            
        }else{
            
            return true;
            
        }
        
    }
    boolean puedeComprarCasilla(){
        
        if(encarcelado){
            
            puedeComprar=false;
            
        }else{
            
            puedeComprar=true;
            
        }
        return puedeComprar;
        
    }
    boolean paga(float cantidad){
        
        return modificarSaldo(cantidad*(-1));
        
    }
    boolean pagaImpuesto(float cantidad){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            return paga(cantidad);
            
        }
        
    }
    boolean pagaAlquiler(float cantidad){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            return paga(cantidad);
            
        }
        
    }
    boolean recibe(float cantidad){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            return modificarSaldo(cantidad);
            
        }
        
    }
    
    boolean modificarSaldo(float cantidad){
        
        saldo = saldo + cantidad;
        Diario.getInstance().ocurreEvento("El saldo de " +nombre+ " se ha modificado a " +saldo);
        return true;
        
    }
    boolean moverACasilla(int numCasilla){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            numCasillaActual = numCasilla;
            puedeComprar = false;
            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " se ha movido a la casilla "+numCasillaActual);
            
        }
        
    }
    private boolean puedoGastar(float precio){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            return saldo >= precio;
            
        }
        
    }
    boolean vender(int ip){
        
        if(encarcelado){
            
            return false;
            
        }else{
            
            if(existeLaPropiedad(ip) && puedeComprarCasilla()){
                
                propiedades.get(ip).vender(this);
                propiedades.remove(ip);
                Diario.getInstance().ocurreEvento("Se ha borrado la propiedad " +ip);
                return true;
            }else{
                
                return false;
                
            }
            
        }
        
    }
    boolean tieneAlgoQueGestionar(){
        
        return (propiedades != null);
        
    }
    private boolean puedeSalirCarcelPagando(){
        
        return saldo>=PrecioLibertad;
        
    }
    boolean salirCarcelPagando(){
        
        if(encarcelado && puedeSalirCarcelPagando()){
            
            paga(PrecioLibertad);
            encarcelado=false;
            Diario.getInstance().ocurreEvento("El jugador "+nombre+ "ha salido de la carcel pagando");
            return true;
        }else{
            
            return false;
            
        }
        
    }
    boolean salirCarcelTirando(){
        boolean dev= false;
        if(Dado.getInstance().salgoDeLaCarcel()){
            
            encarcelado=false;
            Diario.getInstance().ocurreEvento("El jugado " +nombre+ "ha salido de la carcel tirando");
            dev=true;
            
        }
        return dev;
    }
    boolean pasaPorSalida(){
        
        modificarSaldo(PasoPorSalida);
        Diario.getInstance().ocurreEvento("El jugador " +nombre+ " ha pasado por la salida y ha cobrado " +PasoPorSalida);
        return true;
        
    }
    public int compareTo(Jugador otro){
        
       return compare(saldo, otro.getSaldo());
        
    }
    int cantidadCasasHoteles(){
        int total =0;
        for(int i =0; i < propiedades.size(); i++){
            
            total += propiedades.get(i).cantidadCasasHoteles();
            
        }
        return total;
        
    }
    protected String getNombre(){
        
        return nombre;
        
    }
    boolean enBancarrota(){
        
        return saldo<0;
        
    }
    private boolean existeLaPropiedad(int ip){
        
        return (ip>=0 && ip<propiedades.size() && propiedades!=null);
        
    }
    private int getCasasMax(){
        
        return CasasMax;
        
    }
    private int getHotelesMax(){
        
        return HotelesMax;
        
    }
    int getCasasPorHotel(){
        
        return CasasPorHotel;
        
    }
    int getNumCasillaActual(){
        
        return numCasillaActual;
        
    }
    private float getPrecioLibertad(){
        
        return PrecioLibertad;
        
    }
    private float getPremioPasoSalida(){
        
        return PasoPorSalida;
        
    }
    boolean getPuedeComprar(){
        
        return puedeComprar;
        
    }
    protected float getSaldo(){
        
        return saldo;
        
    }
    protected ArrayList<TituloPropiedad> getPropiedades(){
        
        return propiedades;
        
    }
    public boolean isEncarcelado(){
        
        return encarcelado;
        
    }
    public String toString(){
        
        if(encarcelado)
            return "El jugador se llama " +nombre+ ", está encarcelado, se encuentra en la casilla "+numCasillaActual+" y su saldo es " +saldo;
        else
            return "El jugador se llama " +nombre+ ", no está encarcelado, se encuentra en la casilla "+numCasillaActual+" y su saldo es " +saldo;
    }
    private boolean puedoEdificarCasa(TituloPropiedad propiedad){
        
        if(propiedad.getNumCasas()<CasasMax && !enBancarrota())
            return propiedad.construirCasa(this);
        else
            return false;
              
        
    }
    private boolean puedoEdificarHotel(TituloPropiedad propiedad){
        
        if(propiedad.getNumHoteles()<HotelesMax && !enBancarrota())
            return propiedad.construirHotel(this);
        else
            return false;
              
        
    }
}
        
       
      