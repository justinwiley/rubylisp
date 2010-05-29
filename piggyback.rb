class Object
  def lispeval(env, forms); self; end;
  def consify; self; end;
end

class Symbol
  def lispeval(env, forms); env.lookup(self); end;
  
  def arrayify
    self == :nil ? [] : self
  end
  
  def conslist?
    self == :nil
  end
end

class Object
  def consify; self; end;
  def arrayify; self; end;
  def conslist?; false; end;
end

class Array
  def consify
    map{|x| x.consify}.reverse.inject(:nil) {|cdr, car| Cons.new(car, cdr)}
  end
end
