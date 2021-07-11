module Civitas
  class TestP1
    def initialize
      main
    end

    def main
        nombres = Array.new
        nombres.push("Angel")
        nombres.push("Juan")
        nombres.push("Pepe")
        nombres.push("Carlos")
        
      partida = CivitasJuego.new(nombres)
      Dado.instance.setDebug(true)
      vista = Vista_textual.new
      controlador = Controlador.new(partida, vista)
      controlador.juega
    end
  end
end
