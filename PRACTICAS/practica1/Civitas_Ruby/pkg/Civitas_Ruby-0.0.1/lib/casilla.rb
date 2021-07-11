# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding:utf-8
module Civitas
  class Casilla
    def initialize(nom,tip)
        @nombre = nom
        @tipo = tip
    end
    def getnombre()
      
      return @nombre
      
    end
    def gettipo()
      
      return @tipo
      
    end
    def setnombre(nom)
      
      @nombre = nom
      
    end
    def settipo(tip)
      
      @tipo = tip
      
    end
  end
end