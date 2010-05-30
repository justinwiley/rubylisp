require 'rubygems'
require 'spec'
require 'main'

describe 'Main' do
  it "should define a set of default operators from common lisp and scheme" do
    funcs = [:nil, :t, :+, :-, :*, :/, :%, :car, :cdr, :cons, :atom?, :eq?, :list, :print]
    DEFAULTS.keys.map{|x| x.to_s}.sort.should == funcs.map{|x| x.to_s}.sort
  end
end
