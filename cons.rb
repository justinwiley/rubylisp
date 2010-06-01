class Cons
  attr_reader :car, :cdr
  def initialize(car, cdr)
    @car, @cdr = car, cdr
  end
  
  def lispeval(env, forms)
#    LOG.info "Cons.lispeval car: #{car.inspect}, cdr: #{cdr.inspect}"
    return forms.lookup(car).call(env, forms, *cdr.arrayify) if !forms.nil? && forms.defined?(car)
    func = car.lispeval(env, forms)
    return func.respond_to?(:call) ? func.call(*cdr.arrayify.map{|x| x.lispeval(env, forms) }) : func
  end
  
  def arrayify
    conslist? ? [car] + cdr.arrayify : self
#    return self unless conslist?
#    return [car] + cdr.arrayify
  end
  
  def conslist?
    cdr.conslist?
  end
  
  def to_sexp
    return "(cons #{car.to_sexp} #{cdr.to_sexp})" unless conslist?
    return "(#{arrayify.map{|x| x.to_sexp}.join(' ')})"
  end
end