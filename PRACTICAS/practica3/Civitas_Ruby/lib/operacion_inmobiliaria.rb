# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class OperacionInmobiliaria
  def initialize(gest,int)
    @num_propiedad=int
    @gestion=gest
  end
  attr_reader :num_propiedad, :gestion
end
