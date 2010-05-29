require 'rubygems'
require 'spec'
require 'main'

describe Lenv do
  before do
    @l = Lenv.new
    @l.define(:s,1)
  end
  
  it "should accept a parent (be chainable) and defaults" do
    l = Lenv.new @l,{:d=>1}
    l.parent.should == @l
    l.defs.should == {:d => 1}
  end
  
  it "#define should allow a symbol to be bound to value in environment, and return its value" do
    @l.define(:s,1).should == 1
  end
  
  it "#define should allow redefinition of existing symbol" do
    @l.define(:s,3).should == 3
  end
  
  it "#defined? should return true if symbol defined" do
    @l.defined?(:s).should be_true
  end

  it "#defined? should return false if symbol not defined" do
    @l.defined?(:x).should be_false
  end

  it "#defined? should return true if symbol is not defined, but defined in parent env" do
    p = Lenv.new
    p.define(:x,1)
    @l.parent = p
    @l.defined?(:x).should be_true
  end

  it "#lookup should return symbol value if defined" do
    @l.lookup(:s).should == 1
  end

  it "#lookup should raise exception if symbol undef and parent nil" do
    lambda { @l.lookup(:x) }.should raise_error
  end

  it "#lookup should raise exception if symbol undef and symbol undef in parent" do
    @l.parent = Lenv.new
    lambda { @l.lookup(:x) }.should raise_error
  end
  
  it "#lookup should return symbol value if defined in parent" do
    @l.parent = Lenv.new
    @l.parent.define(:x,3)
    @l.lookup(:x).should == 3
  end
  
  it "#set should set the value if defined" do
    @l.set(:s,5).should == 5
  end
  
  it "#set should set the value if under but defined in parent" do
    p = Lenv.new
    p.define(:x,2)
    @l.parent = p
    @l.set(:x,5).should == 5
  end
  
  it "#set should raise exception if symbol undef and parent nil" do
    lambda { @l.set(:x,5) }.should raise_error
  end
  
  it "#set should raise exception if symbol undef and symbol undef in parent" do
    @l.parent = Lenv.new
    lambda { @l.set(:x,5) }.should raise_error
  end
end
