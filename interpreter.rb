FORMS = {}
class Interpreter
  
  def initialize(defaults=DEFAULTS, forms=FORMS)
    @env = Lenv.new(nil, defaults)
    @forms = Lenv.new(nil, forms)
  end
end