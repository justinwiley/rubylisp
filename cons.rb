class Cons
  attr_reader :car, :cdr
  def initialize(car, cdr)
    @car, @cdr = car, cdr
  end
  
  def lispeval(env, forms)
    # added nil check to below
    return forms.lookup(car).call(env, forms, *cdr.arrayify) if !forms.nil? && forms.defined?(car)
    func = car.lispeval(env, forms)
    return func.call(*cdr.arrayify.map{|x| x.lispeval(env, forms) })
  end
  
  def arrayify
    conslist? ? [car] + cdr.arrayify : self
#    return self unless conslist?
#    return [car] + cdr.arrayify
  end
  
  def conslist?
    cdr.conslist?
  end
end