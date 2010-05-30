require 'rubygems'
require 'spec'
require 'main'

describe Interpreter do
  #@env = Lenv.new(nil, defaults)
  #@forms = Lenv.new(nil, forms)
  
  before do
    @i = Interpreter.new
  end
  
  it "#initialize should use DEFAULT by default" do
    @i.instance_variable_get(:@env).should be_kind_of(Lenv)
    @i.instance_variable_get(:@env).defs.should == DEFAULTS
  end
  
  it "#initialize should use forms by default" do
    @i.instance_variable_get(:@forms).should be_kind_of(Lenv)
    @i.instance_variable_get(:@forms).defs.should be_kind_of(Hash)
  end
end
