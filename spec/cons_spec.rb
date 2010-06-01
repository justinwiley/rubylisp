require 'rubygems'
require 'spec'
require 'main'

describe Cons do
  before do
    @l = Lenv.new(nil, {:+ => lambda{|x, y| x + y }}) 
  end

  it "should provide car and cdr" do
    c = Cons.new(1,2)
    c.car.should == 1
    c.cdr.should == 2
  end

  it "should be nestable" do
    c = Cons.new(1,Cons.new(2,Cons.new(3,nil)))
    c.car.should == 1
    c.cdr.cdr.car.should == 3
  end

  it '#lispeval should accept an environment with bound operator and evaluate' do
    env = Lenv.new(nil, {:+ => lambda{|x, y| x + y }})
    Cons.new(:+, Cons.new(1, Cons.new(2, :nil))).lispeval(env, nil)
  end

  it '#lispeval should be compatible with s-expressions' do
    env = Lenv.new(nil, DEFAULTS)
    "(+ 1 3)".parse_sexp.consify.lispeval(env,nil).should == 4
  end

  it '#consify should be compatible with s-expressions' do
    "(+ 1 2)".parse_sexp.consify.should be_kind_of(Cons)
  end

  it '#arrayify should recursively convert conses to arrays' do
    Cons.new(1,Cons.new(2,Cons.new(3,:nil))).arrayify.should == [1,2,3]
  end

  it '#to_sexp should convert regular cons to sexp cons' do
    Cons.new(1,2).to_sexp.should == '(cons 1 2)'
  end

  it '#to_sexp should convert conslist to sexp conslist' do
    Cons.new(1,Cons.new(1,2)).to_sexp.should == '(cons 1 (cons 1 2))'
  end
end

