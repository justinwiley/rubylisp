class Lenv
  attr_accessor :parent, :defs
  def initialize(parent=nil, defaults={})
    @parent = parent
    @defs = defaults
  end
  
  def define(symbol, value)
    @defs[symbol] = value
  end
  
  def defined?(symbol)
    return true if @defs.has_key?(symbol)  # has_key? vs straight hash lookup allows for nils
    return false if @parent.nil?
    @parent.defined?(symbol)
  end
  
  def lookup(symbol)
    return @defs[symbol] if @defs.has_key?(symbol)
    raise "No value for symbol #{symbol}" if @parent.nil?
    @parent.lookup(symbol)
  end
  
  def set(symbol, value)
    if @defs.has_key?(symbol)
      @defs[symbol] = value
    elsif @parent.nil?
      raise "No definition of #{symbol} to set to #{value}"
    else
      @parent.set(symbol, value)
    end
  end
end