class Talk < Event
  attr_reader :type

  def self.find_longest_index(args)
    args[:talks].find_index{|talk| talk.minuets_long < args[:max_length]}
  end

  def initialize(args)
    @type = 'talk'
    super
  end

  def greater_thans(talk)
  		# Am i greater than 
	end

end