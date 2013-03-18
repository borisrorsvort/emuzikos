require 'zeus/rails'

class Popeye < Zeus::Rails
  def spinach_environment
    require 'spinach'
  end

  def spinach
    cli = Spinach::Cli.new(ARGV)
    exit cli.run
  end
end

Zeus.plan = Popeye.new
