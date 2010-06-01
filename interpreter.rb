SPECIAL_FORMS = {
  :quote   => lambda {|env, forms, exp| exp },
  :define  => lambda {|env, forms, sym, value| env.define(sym, value.lispeval(env, forms)) }, 
  :set!    => lambda {|env, forms, sym, value| env.set(sym, value.lispeval(env, forms)) },
}

class Interpreter
  def initialize(defaults=DEFAULTS, forms=SPECIAL_FORMS)
    @env = Lenv.new(nil, defaults)
    @forms = Lenv.new(nil, forms)
  end
  
  def eval(string)
    exps = "(#{string})".parse_sexp
    exps.map do |exp|
      exp.consify.lispeval(@env, @forms)
    end.last
  end

  def prompt
    puts "> "
  end
  
  def repl
    prompt
    STDIN.each_line do |line|
      begin
        puts self.eval(line).to_sexp
      rescue StandardError => e
        puts "ERROR: #{e}"
      end
    prompt
    end
  end
end