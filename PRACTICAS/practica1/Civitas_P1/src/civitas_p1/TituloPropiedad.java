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
public class TituloPropiedad {
    
    private String nombre;
    private float alquilerBase;
    private float factorRevalorizacion;
    private final float factorInteresHipoteca = (float) 1.1;
    private float hipotecaBase;
    private float PrecioCompra;
    private float PrecioEdificar;
    private boolean hipotecado;
    private int numCasas;
    private int numHoteles;
    private Jugador propietario;
    
    TituloPropiedad(String nom,float base_alq,float factor_rev,float base_hipot,float precio_comp,float precio_edif){
        
        nombre=nom;
        alquilerBase=base_alq;
        factorRevalorizacion=factor_rev;
        hipotecaBase=base_hipot;
        PrecioCompra=precio_comp;
        PrecioEdificar=precio_edif;
        propietario = null;
        numCasas = 0;
        numHoteles = 0;
        hipotecado=false;
    }
    
    
    public String toString(){
        
        if(hipotecado)
            return "La propiedad " + nombre + " es de " + propietario.getNombre() + " con un alquiler base de " + alquilerBase +  ", una hipoteca base de " + hipotecaBase + ", un precio de compra de " + PrecioCompra + ", un precio de edificacion de " + PrecioEdificar + " " +numCasas+ " casas y " +numHoteles + " hoteles";
        else
            return "La propiedad " + nombre + " no está hipotecada por nadie. Tiene un alquiler base de " + alquilerBase +", una hipoteca base de " +hipotecaBase+ ", un precio de compra de " +PrecioCompra +", un precio de edificacion de " +PrecioEdificar +", " +numCasas +" casas y " +numHoteles + " hoteles" ;
            
    }
    private float getPrecioAlquiler(){
        if(hipotecado || propietario.propietarioEncarcelado())
            return 0;
        else
            return (float) (alquilerBase*(1+(numCasas*0.5)+(numHoteles*2.5)));
        
    }
    float getImporteCancelarHipoteca(){
        
        return hipotecaBase*factorInteresHipoteca;
        
    }
    boolean cancelarHipoteca(Jugador jugador){
        
        boolean sehace=false;
        
        if(hipotecado && esEsteElPropietario(jugador)){
            
            propietario.paga(getImporteCancelarHipoteca());
            hipotecado=false;
            sehace =true;
            
        }
        
        return sehace;
        
    }
    boolean hipotecar(Jugador jugador){
        
        boolean sehace = false;
        
        if(!hipotecado && esEsteElPropietario(jugador)){
            propietario.recibe(hipotecaBase);
            hipotecado=true;
            sehace = true;
        }
        
        return sehace;
        
    }
    void tramitarAlquiler(Jugador jugador){
        
        if(propietario != null && !esEsteElPropietario(jugador)){
            
            jugador.pagaAlquiler(getPrecioAlquiler());
            propietario.recibe(getPrecioAlquiler());
            
        }
        
    }
    private boolean propietarioEncarcelado(){
        
        if(!propietario.propietarioEncarcelado() || propietario == null)
            return false;
        else
            return true;
        
    }
    int cantidadCasasHoteles(){
        
        return numCasas+numHoteles;
        
    }
    boolean derruirCasas(int n, Jugador jugador){
        
        boolean sehace=false;
        
        if(numCasas>=n && esEsteElPropietario(jugador)){
            
            numCasas=numCasas-n;
            sehace = true;
            
        }
        
        return sehace;
        
    }
    private float getPrecioVenta(){
        
        return PrecioCompra+cantidadCasasHoteles()*PrecioEdificar*factorRevalorizacion;
        
    }
    boolean construirCasa(Jugador jugador){
        
        boolean sehace=false;
        
        if(esEsteElPropietario(jugador)){
            
            jugador.paga(PrecioEdificar);
            numCasas++;
            sehace=true;
            
        }
        
        return sehace;
        
    }
    boolean construirHotel(Jugador jugador){
        
        boolean sehace=false;
        
        if(esEsteElPropietario(jugador)){
            
            jugador.paga(PrecioEdificar);
            numHoteles++;
            sehace=true;
            
        }
        
        return sehace;
        
    }
    boolean Comprar(Jugador jugador){
        
        if(propietario!=null){
            
            propietario=jugador;
            jugador.paga(PrecioCompra);
            return true;
            
        }else{
            
            return false;
            
        }
        
    }
    boolean tiene_propietario(){
        
        return propietario != null;
        
    }
    
    void actualizaPopietarioPorConversion(Jugador jugador){
        
        propietario=jugador;
        
    }
    private boolean esEsteElPropietario(Jugador jugador){
        
        return propietario==jugador;
        
    }        
    boolean vender(Jugador jugador){
        
        if(jugador.getSaldo()>= PrecioCompra &&jugador!=propietario){
            jugador.paga(PrecioCompra);
            propietario=jugador;
            return true;
        }else{
            return false;
        }
    }
    private float getImporteHipoteca(){
        
        return (float) (hipotecaBase*(1+(numCasas*0.5)+(numHoteles*2.5)));

        
    }
    int getNumCasas(){
        
        return numCasas;
        
    }
    int getNumHoteles(){
        
        return numHoteles;
        
    }
    float getPrecioCompra(){
        
        return PrecioCompra;
        
    }
    float getPrecioEdificar(){
        
        return PrecioEdificar;
        
    }
    Jugador getPropietario(){
        
        return propietario;
        
    }
    
       
}
