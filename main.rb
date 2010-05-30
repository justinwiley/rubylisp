#!/bin/env ruby
DEFAULTS = { :nil => :nil,
  :t        => :t,
  :+        => lambda {|x,y| x + y },
  :-        => lambda {|x,y| x - y },
  :*        => lambda {|x,y| x * y },
  :/        => lambda {|x,y| x / y },
  :%        => lambda {|x,y| x % y },
  :car      => lambda {|x| x.car },
  :cdr      => lambda {|x| x.cdr },
  :cons     => lambda {|x,y| Cons.new(x,y) },
  :atom?    => lambda {|x| x.kind_of?(Cons) ? :nil : :t},
  :eq?      => lambda {|x,y| x.equal?(y) ? :t : :nil},
  :list     => lambda {|*args| Cons.from_a(args)},
  :print    => lambda {|*args| puts *args; :nil },
}
SORTED_DEFAULT_KEYS = DEFAULTS.keys.map{|x| x.to_s}.sort

require 'rubygems'
gem 'sexp'  # prevent other gem definitions of sexp like in ParseTree
require 'sexp'
require 'piggyback'
require 'cons'
require 'lenv'
require 'interpreter'
