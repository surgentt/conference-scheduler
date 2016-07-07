class Event
  attr_reader :name, :minuets_long
  attr_accessor :track, :start_time, :end_time

  def self.sort(talks)
    talks.sort{|x,y| y.minuets_long <=> x.minuets_long}
  end

  def name=(name)
    @name = name
  end

  def initialize(args)
    @name = args[:name]
    @minuets_long = args[:minuets_long] ||= 5
    @start_time = args[:start_time] if args[:start_time]
    @end_time = args[:end_time] if args[:end_time]
  end

  def set_times(last_event_time)
    self.start_time = last_event_time
    self.end_time = self.start_time + self.minuets_long.minutes
  end

  def start_time_in_mins
    self.start_time.hour*60+self.start_time.minute
  end

  def end_time_in_mins
    self.end_time.hour*60+self.end_time.minute
  end

  def txt_print
    "#{self.start_time.strftime('%I:%M%p')} #{self.name} #{self.minuets_long}min \n"
  end

end