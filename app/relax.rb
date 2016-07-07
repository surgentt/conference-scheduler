class Relax < Event
  attr_reader :type
  attr_writer :name

  def initialize(args)
    @type = 'relax'
    super
  end

end