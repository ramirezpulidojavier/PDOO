/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package civitas_p1;

/**
 *
 * @author angel
 */
public class TituloPropiedad {
    
    private String nombre;
    private float alquilerBase;
    private float hipotecaBase;
    private float precioCompra;
    private float precioEdificar;
    private Jugador propietario;
    private static final float FACTORINTERESHIPOTECA = (float) 1.1;
    private float factorRevalorizacion;
    private boolean hipotecado;
    private int numCasas;
    public int numHoteles;
            
    
    TituloPropiedad(String name, float pBaseAlquiler, float fRevalorizacion, float pBaseHipoteca, float pCompra, float pEdificar  ){
        
        nombre = name;
        alquilerBase = pBaseAlquiler;
        hipotecaBase = pBaseHipoteca;
        precioCompra = pCompra;      
        precioEdificar = pEdificar;
        propietario = null;
        factorRevalorizacion = fRevalorizacion;
        hipotecado = false;
        numCasas = 0;
        numHoteles = 0;        
        
    }
    
    @Override
    public String toString(){
        
        if (hipotecado)
            return "La propiedad " + nombre + " pertenece a " + propietario.getNombre() + " y está hipotecada. Tiene " + numCasas + " casas, "
                    + numHoteles + " hoteles, precio de compra " + precioCompra +" $, precio edificar " + precioEdificar + " $, factor de revalorizacion = "
                    + factorRevalorizacion + ", alquiler base de " + alquilerBase + " $ y una hipoteca base de " + hipotecaBase + " $.";
        else
            return "La propiedad " + nombre + " pertenece a " + propietario.getNombre() + " y no está hipotecada. Tiene " + numCasas + " casas, "
                    + numHoteles + " hoteles, precio de compra " + precioCompra +" $, precio edificar " + precioEdificar + " $, factor de revalorizacion = "
                    + factorRevalorizacion + ", alquiler base de " + alquilerBase + " $ y una hipoteca base de " + hipotecaBase + " $.";
        
    }
    
    
    
    public float getPrecioAlquiler(){
        if (hipotecado || propietario.isEncarcelado())
            return 0;
        else
            return (float) (alquilerBase*(1+(numCasas*0.5)+(numHoteles * 2.5)));
        
    }
    
    float getImporteCancelarHipoteca(){
    
        return hipotecaBase * FACTORINTERESHIPOTECA;
    
    }   
    
    boolean cancelarHipoteca(Jugador jugador){
        
        boolean result = false; 
        
        if(hipotecado && esEsteElPropietario(jugador)){      
            jugador.paga(getImporteCancelarHipoteca());
            result = true;
            hipotecado = false;
        }
        
        return result;
        
    }
    
    String getNombre(){
        return nombre;
    }
    
    Boolean hipotecar(Jugador jugador){
        
        if (!hipotecado && esEsteElPropietario(jugador)){
            hipotecado = true;
            jugador.modificarSaldo(hipotecaBase);
            return true;
        }
        else
            return false;
        
    }
    
    void tramitarAlquiler (Jugador jugador){
        
        float precio;
        
        if(tienePropietario()){
        
            if (!esEsteElPropietario(jugador)){
            precio = getPrecioAlquiler();
            jugador.pagaAlquiler(precio);
            propietario.recibe(precio);
                
            }
            
            
            
        }
                  
    }
    
    private boolean propietarioEncarcelado(){
        
        if (propietario != null && propietario.isEncarcelado()) 
            return true;
        else
            return false;
        
    }
    
    int cantidadCasasHoteles(){
        return numCasas + numHoteles;
    }
    
    boolean derruirCasas( int n, Jugador jugador){
        
        if (esEsteElPropietario(jugador) && n <= numCasas){ //esEsteElPropietario(Jugador jugador)
            numCasas -= n;
            return true;
            
        }
        else
            return false;
    }
    
    private float getPrecioVenta(){
        return precioCompra + (numCasas + 5*numHoteles) * precioEdificar * factorRevalorizacion;
    }
    
    
    boolean construirCasa(Jugador jugador){
        
        boolean construir = false;
        
        if (esEsteElPropietario(jugador)){ 
            jugador.modificarSaldo(precioEdificar*(-1));
            numCasas++;
            construir = true;
        }
        
        return construir;
        
    }
    
    boolean construirHotel(Jugador jugador){
        
        boolean result = false;
        
        if (esEsteElPropietario(jugador)){ 
            propietario.paga(precioEdificar); 
            numHoteles++;
            result = true;
        }
        
        return result;

    }
    
    boolean comprar (Jugador jugador){
        
        boolean result = false;

        if (!tienePropietario()){
            propietario = jugador;
            result = true;
            jugador.paga(precioCompra);
        }

        return result;
        
    } 
    
    boolean vender(Jugador player){
        
        if (esEsteElPropietario(player) && !hipotecado){
            propietario.recibe(getPrecioVenta());
            derruirCasas(numCasas, propietario);
            numHoteles = 0;
            propietario = null;
            return true;
        }
        else
            return true;
    }
    
    public boolean esEsteElPropietario(Jugador player){        
        return propietario == player;        
    }
    
    void actualizaPropieatarioPorConversion(Jugador jugador){
        propietario = jugador;
    }
    
    public boolean getHipotecado(){
        
        return hipotecado;
    
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
        return precioCompra;
    }
    
    float getPrecioEdificar(){
        return precioEdificar;
    }
    
    
    Jugador getPropietario(){
        return propietario;
    }
    
    boolean tienePropietario(){
        return propietario != null;
    }
    
   
}
