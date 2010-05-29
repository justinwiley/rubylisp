require 'rubygems'
require 'spec'
require 'main'

describe 'Piggyback' do
  before do
    @l = Lenv.new
    @l.define(:s,1)
  end
  
  it 'Object#lispeval should evaluate to self' do
    o = Object.new
    o.lispeval(@l,nil).should == o
  end

  it 'Symbol#lispeval should evaluate to symbol defined in environment' do
    :s.lispeval(@l,nil).should == 1
  end

  it 'Symbol#lispeval should raise exception if undefined' do
    lambda { :x.lispeval(@l,nil) }.should raise_error
  end


end