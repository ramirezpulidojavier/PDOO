module Civitas

class TestP2
  def initialize
    main
  end
  
  def main
    nombres = Array.new
      
    nombres.push("Victor")
    nombres.push("Francis")
    nombres.push("Alejandro")
    nombres.push("Elvira")
      
    puts nombres
    
    juego = CivitasJuego.new(nombres)
    
    juego.getJugadorActual.modificarSaldo(10000)
    puts "salvoconducto: #{juego.getJugadorActual.tieneSalvoconducto}"
    puts "algo que gestionar: #{juego.getJugadorActual.tieneAlgoQueGestionar}"
    puts "en bancarrota: #{juego.getJugadorActual.enBancarrota}"
    puts "puede comprar: #{juego.getJugadorActual.puedeComprar}"
    puts "paga impuesto: #{juego.getJugadorActual.pagaImpuesto(500)}"
    juego.getJugadorActual.encarcelar(5)
    puts "puede comprar: #{juego.getJugadorActual.puedeComprar}"
    puts "paga impuesto: #{juego.getJugadorActual.pagaImpuesto(500)}"
    
    titulo = TituloPropiedad.new("casa", 5, 5, 5, 5, 5)
    puts titulo.toString
    puts titulo.cantidadCasasHoteles
    puts titulo.construirCasa(juego.getJugadorActual)
    puts titulo.comprar(juego.getJugadorActual)
    puts titulo.construirCasa(juego.getJugadorActual)
    puts titulo.construirHotel(juego.getJugadorActual)
    puts titulo.vender(juego.getJugadorActual)
    juego.getJugadorActual.salirCarcelPagando
    puts titulo.vender(juego.getJugadorActual)
    
    ranking = juego.ranking
    puts "RANKING:"
    for i in (0..ranking.length-1)
      pos = i+1
      puts "#{pos}. #{ranking[ranking.length-i-1].nombre} , #{ranking[ranking.length-i-1].saldo}"
    end
  end
end
end