/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GUI;

import civitas_p1.Jugador;
import civitas_p1.JugadorEspeculador;
import civitas_p1.Tablero;
import civitas_p1.TituloPropiedad;
import java.awt.Image;
import java.util.ArrayList;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JLabel;


public class JugadorPanel extends javax.swing.JPanel {

    Jugador jugador ;
    
    void setJugador(Jugador player){
        
        jugador = player;
        
        Nombre.setText(jugador.getNombre());
        Encarcelado.setText(Boolean.toString(jugador.isEncarcelado()));
        Especulador.setText(Boolean.toString(jugador.isEspeculador()));
        Saldo.setText(Float.toString(jugador.getSaldo()));
        NumCasillaAct.setText(Integer.toString(jugador.getNumCasillaActual()));
        TieneSalvoconducto.setText(Boolean.toString(jugador.tieneSalvoconducto()));
      
        
        
        Icon icono;
        
        
        if(jugador.getNumCasillaActual()==1){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO2.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==2){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO3.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==3){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO4.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==4){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO5.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==5){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO6.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==6){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO7.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==7){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO8.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==8){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO9.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==9){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO10.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==10){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO11.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==11){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO12.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==12){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO13.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==13){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO14.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==14){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO15.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==15){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO16.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==16){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO17.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==17){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO18.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==18){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO19.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==19){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO20.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        if(jugador.getNumCasillaActual()==20){
            icono = new ImageIcon(getClass().getResource("/fotos/TABLEROPRO20.jpg"));
            imagenTablero.setIcon(icono);
        }
        
        
        
        repaint();
        rellenaPropiedades(jugador.getPropiedades());
        
        
        
        
    }
   
    
    
    @Override
    public void repaint() {
        super.repaint(); //To change body of generated methods, choose Tools | Templates.
    }
    
    
    private void rellenaPropiedades(ArrayList<TituloPropiedad>lista){
        
        //Se elimina la informacion antigua
        jPanel1.removeAll();
        //Se recorre la lista de propiedades para ir creando sus vistas individuales y añadirlas al panel
        for (TituloPropiedad t:lista){
            PropiedadPanel vistaPropiedad = new PropiedadPanel();
            vistaPropiedad.setPropiedad(t);
            
            jPanel1.add(vistaPropiedad);
            vistaPropiedad.setVisible(true);
        }
        //Se fuerza la actualización visual del panel propiedades y del panel del jugador 
        repaint();
        revalidate();
        
    }
    
    
    /**
     * Creates new form JugadorPanel
     */
    public JugadorPanel() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        Nombre = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        jPanel1 = new javax.swing.JPanel();
        Saldo = new javax.swing.JTextField();
        Encarcelado = new javax.swing.JTextField();
        Especulador = new javax.swing.JTextField();
        NumCasillaAct = new javax.swing.JTextField();
        TieneSalvoconducto = new javax.swing.JTextField();
        tieneSalvoconducto = new javax.swing.JLabel();
        numCasillaAct = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        imagenTablero = new javax.swing.JLabel();

        jLabel1.setText("Nombre:");
        jLabel1.setEnabled(false);

        jLabel2.setText("Saldo:");
        jLabel2.setEnabled(false);

        jLabel3.setText("¿Encarcelado?:");
        jLabel3.setEnabled(false);

        Nombre.setEnabled(false);

        jLabel4.setText("¿Especulador?:");
        jLabel4.setEnabled(false);

        Saldo.setEnabled(false);
        Saldo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SaldoActionPerformed(evt);
            }
        });

        Encarcelado.setEnabled(false);

        Especulador.setEnabled(false);
        Especulador.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                EspeculadorActionPerformed(evt);
            }
        });

        NumCasillaAct.setEnabled(false);
        NumCasillaAct.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                NumCasillaActActionPerformed(evt);
            }
        });

        TieneSalvoconducto.setEnabled(false);

        tieneSalvoconducto.setText("¿Tiene Salvoconducto?:");
        tieneSalvoconducto.setEnabled(false);

        numCasillaAct.setText("Casilla Actual:");
        numCasillaAct.setEnabled(false);

        jLabel6.setText("Vista de Jugador");
        jLabel6.setEnabled(false);

        imagenTablero.setIcon(new javax.swing.ImageIcon(getClass().getResource("/fotos/TABLEROPRO.jpg"))); // NOI18N

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(numCasillaAct)
                        .addGap(18, 18, 18)
                        .addComponent(NumCasillaAct, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(18, 18, 18)
                        .addComponent(Nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel6)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addGap(18, 18, 18)
                        .addComponent(Saldo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel3)
                            .addComponent(jLabel4))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(Especulador, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(Encarcelado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(tieneSalvoconducto)
                        .addGap(18, 18, 18)
                        .addComponent(TieneSalvoconducto, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(18, 18, 18)
                .addComponent(imagenTablero, javax.swing.GroupLayout.PREFERRED_SIZE, 655, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(51, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(imagenTablero, javax.swing.GroupLayout.PREFERRED_SIZE, 509, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel6)
                                .addGap(18, 18, 18)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel1)
                                    .addComponent(Nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel2)
                                    .addComponent(Saldo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(Encarcelado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(Especulador, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(numCasillaAct)
                            .addComponent(NumCasillaAct, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(tieneSalvoconducto)
                            .addComponent(TieneSalvoconducto, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void EspeculadorActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_EspeculadorActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_EspeculadorActionPerformed

    private void SaldoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SaldoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_SaldoActionPerformed

    private void NumCasillaActActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_NumCasillaActActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_NumCasillaActActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField Encarcelado;
    private javax.swing.JTextField Especulador;
    private javax.swing.JTextField Nombre;
    private javax.swing.JTextField NumCasillaAct;
    private javax.swing.JTextField Saldo;
    private javax.swing.JTextField TieneSalvoconducto;
    public javax.swing.JLabel imagenTablero;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JLabel numCasillaAct;
    private javax.swing.JLabel tieneSalvoconducto;
    // End of variables declaration//GEN-END:variables

    
   
}

