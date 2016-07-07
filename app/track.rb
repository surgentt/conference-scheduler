class Track
  attr_reader :start_time
  attr_accessor :events

  def self.find_largest_window(tracks)
    tracks_large_window = []
    tracks.each_with_index do |track, index|
      window_hash = track.largest_window
      window_hash[:track_int] = index
      tracks_large_window <<  window_hash
    end
    tracks_large_window.max_by{|x| x[:length]} #=> {track_int: 0, length: 40, start_time: DateTime}
  end

  def initialize(args)
    start_date = args[:start_date] ||= DateTime.current.midnight
    @start_time = start_date.change({hour: 9})
    @events = [
      Relax.new({ name: 'Lunch', minuets_long: 60, start_time: start_date.change({hour: 12}), end_time: start_date.change({hour: 13}) }),
      Relax.new({ name: 'Networking Window', minuets_long: 60, start_time: start_date.change({hour: 16}), end_time: start_date.change({hour: 17}) })
    ]
  end

  def largest_window
    windows = []
    if morning_talks.empty?
      windows << {length:  minutes_between(lunch.start_time, self.start_time), start_time: self.start_time }
    else
      windows << {length: minutes_between(lunch.start_time, last_morning_talk.end_time), start_time: last_morning_talk.end_time}
    end

    if afternoon_talks.empty?
      windows << {length: minutes_between(networking.end_time, lunch.end_time), start_time: lunch.end_time }
    else
      windows << {length: minutes_between(networking.end_time, last_afternoon_talk.end_time), start_time: last_afternoon_talk.end_time}
    end
    windows.max_by{|x| x[:length]}
  end

  def add_talk(args)
    args[:talk].set_times(args[:last_event_time])
    self.events << args[:talk]
  end

  def events_txt_print
    self.update_networking
    self.sort_events!
    text = ''
    self.events.each do |event|
      text << event.txt_print
    end
    text
  end

  def talks
    self.events.select{|event| event.type == 'talk'}
  end

  def breaks
    self.events.select{|event| event.type == 'relax'}
  end

  protected

  def update_networking
    networking.set_times(last_afternoon_talk.end_time)
    networking.name = 'Networking Event'
  end

  def sort_events!
    self.events = self.events.sort{ |x,y| x.start_time <=> y.start_time }
  end

  private

  def lunch
    self.breaks.detect{|relax| relax.name=='Lunch' }
  end

  def networking
    self.breaks.detect{|relax| relax.name=='Networking Window' }
  end

  def morning_talks
    self.talks.select{|talk| talk.start_time <= lunch.start_time}
  end

  def afternoon_talks
    self.talks.select{|talk| talk.start_time >= lunch.end_time}
  end

  def last_morning_talk
    morning_talks.max_by{|talk| talk.end_time}
  end

  def last_afternoon_talk
    afternoon_talks.max_by{|talk| talk.end_time}
  end

  def minutes_between(time1, time2)
    ((time1 - time2)*24*60).to_i
  end

end