require 'rubygems'
require 'spec'
require 'main'

describe 'Piggyback' do
  before do
    @l = Lenv.new
    @l.define(:s,1)
    @o = Object.new
  end
  
  it 'Object#lispeval should evaluate to self' do
    @o.lispeval(@l,nil).should == @o
  end
  
  it 'Object#arrayify should evaluate to self' do
    @o.arrayify.should == @o
  end

  it 'Object#conslist? should return false' do
    @o.conslist?.should be_false
  end

  it 'Symbol#lispeval should evaluate to symbol defined in environment' do
    :s.lispeval(@l,nil).should == 1
  end

  it 'Symbol#lispeval should raise exception if undefined' do
    lambda { :x.lispeval(@l,nil) }.should raise_error
  end

  it 'Symbol#arrayify should return self if nil' do
    :s.arrayify.should == :s
  end

  it 'Symbol#arrayify should return self if nil' do
    :s.arrayify.should == :s
  end

  it 'Object#consify should evaluate to self' do
    @o.consify.should == @o
  end

  it 'Array#consify should convert arrays to stream of conses' do
    [1,2,3].consify.cdr.car.should == 2
  end
end