/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

import static java.lang.Float.compare;
import java.util.ArrayList;
import GUI.Dado;

    
public class Jugador implements Comparable<Jugador>{
    
    protected static final int CASASMAX = 4;
    protected static final int CASASPORHOTEL = 4;
    protected boolean encarcelado;
    protected static final int HOTELESMAX = 4;
    protected String nombre;
    protected int numCasillaActual;
    protected static final float PASOPORSALIDA = 100;
    protected static final float PRECIOLIBERTAD = 200;
    protected boolean puedeComprar;
    protected float saldo;
    private static final float SALDOINICIAL = 7500;
    protected ArrayList<TituloPropiedad> propiedades;
    protected Sorpresa salvoconducto;
    protected boolean especulador;
    
    @Override
    public int compareTo(Jugador otro) {
        if (saldo > otro.saldo) {
            return -1;
        }
        if (saldo < otro.saldo) {
            return 1;
        }
        return 0;

    }
    
    Jugador(String nombre){
        
        encarcelado = false;
        this.nombre = nombre;
        numCasillaActual = 0;
        puedeComprar = true;
        saldo = SALDOINICIAL;
        propiedades = new ArrayList<TituloPropiedad>();
        salvoconducto = null;
        especulador = false;
        
    }
    
    protected Jugador (Jugador jugador){
        encarcelado = jugador.encarcelado;
        nombre = jugador.nombre;
        numCasillaActual = jugador.numCasillaActual;
        puedeComprar = jugador.puedeComprar;
        saldo = jugador.saldo;
        salvoconducto = jugador.salvoconducto;
        /*
        propiedades = new ArrayList<>();
        
        if (!jugador.propiedades.isEmpty())
            for (int i = 0; i < jugador.propiedades.size(); i++)
                propiedades.set(i, jugador.propiedades.get(i));
        else
            propiedades = null;
        */
        propiedades= jugador.propiedades;
        especulador = false;
    }
    
    
    public boolean isEspeculador(){ //era paquete
        return especulador;
    }
    
    void setEspeculador(boolean es_especulador){
        especulador = es_especulador;
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
    
    public void duplicarSaldo(){
        saldo = saldo*2;
    }
    
    boolean encarcelar(int numCasillaCarcel){
        if (debeSerEncarcelado()){
            moverACasilla(numCasillaCarcel);
            encarcelado = true;
            Diario.instance.ocurreEvento("El jugador " + nombre + " ha sido trasladado a la carcel.");
        }
        else
            Diario.instance.ocurreEvento("El jugador " + nombre + " no ha sido trasladado a la carcel.");
        
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
    
    protected void perderSalvoconducto(){
        ( (SorpresaSalirCarcel) salvoconducto).usada();
        salvoconducto = null;
    }
    
    public boolean tieneSalvoconducto(){ //era paquete
        return salvoconducto != null;
    }
    
    boolean puedeComprarCasilla(){
        puedeComprar = !encarcelado;
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
        else{
            boolean m = modificarSaldo(cantidad);
            return m;
            
        }
    }
    
    boolean modificarSaldo(float cantidad){
        saldo += cantidad;
        Diario.instance.ocurreEvento("El saldo del jugador " + nombre + " ha sido modificado a " + saldo);
        return true;
    }
    
    boolean moverACasilla(int numCasilla){
        if (!encarcelado){
            numCasillaActual = numCasilla;
            puedeComprar = false;
            Diario.instance.ocurreEvento("El jugador " + nombre + " ha sido movido a la casilla " + numCasilla);
           return true;
        }
        else{
            Diario.instance.ocurreEvento("El jugador " + nombre + " no ha sido movido porque esta encarcelado");
            return false;
        }
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
                    Diario.instance.ocurreEvento("El jugador " + nombre + " ha vendido la propiedad " + propiedades.get(ip).getNombre());
                    propiedades.remove(ip);
                    return true;
                }
                
            }
       
        
        }
            
        Diario.instance.ocurreEvento("El jugador " + nombre + " no ha podido vender la propiedad (porque estaba encarcelada o no es suya) " + propiedades.get(ip).getNombre());       
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
            Diario.instance.ocurreEvento("El jugador " + nombre + " sale de la carcel pagando\n");
            return true;
        }

        Diario.instance.ocurreEvento("El jugador " + nombre + " no ha podido salir de la carcel pagando (no tiene money) \n");
        return false;
        
    }
    
    boolean salirCarcelTirando(){
        if(Dado.getInstance().salgoDeLaCarcel()){
            encarcelado = false;
            Diario.instance.ocurreEvento("El jugador " + nombre + " sale de la carcel.");
            return true;
        }   
        
        Diario.instance.ocurreEvento("El jugador " + nombre + " ha tirado pero no sale de la carcel.");
        return false;
    }
    
    
    boolean pasaPorSalida(){
        int x = 0;
        modificarSaldo(PASOPORSALIDA);
        Diario.instance.ocurreEvento("El jugador " + nombre + " pasa por salida y cobra 100.");
        return true;
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
    
    int getCasasMax(){
        return CASASMAX;
    }
    
    int getCasasPorHotel(){
        return CASASPORHOTEL;
    }
    
    int getHotelesMax(){
        return HOTELESMAX;
    }
    
    public String getNombre(){ //era protected
        return nombre;
    }
    
    public int getNumCasillaActual(){ //era paquete
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
    
    public float getSaldo(){ //era protected
        return saldo;
    }
    
    public boolean isEncarcelado(){
        return encarcelado;
    }
    
    private boolean puedoEdificarCasa(TituloPropiedad propiedad){
        
        float precio = propiedad.getPrecioEdificar();
        
        return propiedad.esEsteElPropietario(this) && propiedad.getNumCasas() < getCasasMax() && this.puedoGastar(precio);
        
    }
    
    private boolean puedoEdificarHotel(TituloPropiedad propiedad){
        
        float precio = propiedad.getPrecioEdificar();
        
        return propiedad.getNumCasas() ==  getCasasMax() && propiedad.getNumHoteles() < getHotelesMax() && this.puedoGastar(precio);
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
                else{
                    Diario.getInstance().ocurreEvento("El jugador "+nombre+ " no puede cancelar la hipoteca de la propiedad " +propiedades.get(ip).getNombre());
                }
                
                
            }else
                Diario.getInstance().ocurreEvento("El jugador "+nombre+ " no puede cancelar la hipoteca de la propiedad " +propiedades.get(ip).getNombre());
            
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
                    Diario.instance.ocurreEvento("El jugador "+nombre+ " compra " + titulo.toString());
                }
                
                puedeComprar = false;
                                
            }
            
            

       }

        return result;
           
           
        }
    
    
    void construirLoMaximo(int ip){
        
        if (propiedades.get(ip).getHipotecado())
            cancelarHipoteca(ip);
        
        boolean salir = false;
   
        while (!salir){

            construirCasa(ip);
            construirHotel(ip);
            
            if ((propiedades.get(ip).getNumCasas() == 4 && propiedades.get(ip).getNumHoteles() == 4) || saldo <= propiedades.get(ip).getPrecioEdificar()){
                salir = true;
            }
                
            
        }
            
            
            
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
                
                
                if(especulador)
                    casasPorHotel=getCasasPorHotel()*2;
                else
                    casasPorHotel=getCasasPorHotel();
                
                propiedad.derruirCasas(casasPorHotel, this);
                Diario.getInstance().ocurreEvento("El jugador "+nombre+" construye hotel en la propiedad "+ propiedades.get(ip).getNombre());
            }
            else{
                if(especulador)
                    Diario.getInstance().ocurreEvento("El jugador "+nombre+" no construye hotel en la propiedad " + propiedades.get(ip).getNombre() + " porque no tiene 8 casas construidas o no tiene dinero.\n");
                else
                    Diario.getInstance().ocurreEvento("El jugador "+nombre+" no construye hotel en la propiedad " + propiedades.get(ip).getNombre() + " porque no tiene 4 casas construidas o no tiene dinero.\n");
                
            }
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
                        
                        Diario.getInstance().ocurreEvento("El jugador " +nombre+ " construye casa en la propiedad "+ propiedades.get(ip).getNombre());
                        
                    }
                    else{
                        if(especulador)
                            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " no puede construir casa en la propiedad (porque ya tiene 8 o no tiene dinero) "+ propiedades.get(ip).getNombre() + "\n");
                        else
                            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " no puede construir casa en la propiedad (porque ya tiene 4 o no tiene dinero) "+ propiedades.get(ip).getNombre() + "\n");
                    }
                }
                else{
                    if(especulador)
                        Diario.getInstance().ocurreEvento("El jugador " +nombre+ " no puede construir casa en la propiedad (porque ya tiene 8 o no tiene dinero) "+ propiedades.get(ip).getNombre() + "\n");
                    else
                        Diario.getInstance().ocurreEvento("El jugador " +nombre+ " no puede construir casa en la propiedad (porque ya tiene 4 o no tiene dinero) "+ propiedades.get(ip).getNombre() + "\n");
                    
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
            result = propiedades.get(ip).hipotecar(this);
                     
        }
        if(result){
            
            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " hipoteca la propiedad "+ propiedades.get(ip).getNombre());
        }
        else
            Diario.getInstance().ocurreEvento("El jugador " +nombre+ " no puede hipotecar la propiedad "+ propiedades.get(ip).getNombre());
        
        return result;
    }
    
    
    @Override
    public String toString(){       
        return this.getClass().getSimpleName() +" de nombre " + nombre + " situado en la casilla " + numCasillaActual + " con saldo " + saldo;
    }
    
    
}
