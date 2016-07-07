class Scheduler
  attr_accessor :tracks, :unplaced_talks
  attr_reader :date

  def initialize(args)
    @date =  create_date([args[:year], args[:month], args[:day],0,0,0,args[:offset]])
    @unplaced_talks = args[:talks]
    @tracks = [create_track]
  end

  def run
    self.unplaced_talks = Event.sort(self.unplaced_talks)
    until self.unplaced_talks.empty?
      # Loop through track and ask each which the largest window is. 
      # The track doesn't need to know about its other tracks. 
      # This would remove the need for the track to reutrn the int. 

      track_window = Track.find_largest_window(tracks) # =>{track_int: 0, length: 40, star_time: DateTime}


      unplaced_talk_int = Talk.find_longest_index({talks: unplaced_talks, max_length: track_window[:length]})
      if unplaced_talk_int
        self.tracks[track_window[:track_int]].add_talk({talk: self.unplaced_talks[unplaced_talk_int], last_event_time: track_window[:start_time]})
        self.unplaced_talks.delete_at(unplaced_talk_int)
      else
        self.tracks << create_track
      end
    end
    txt_print
    puts 'Program Finished!'
  end

  private

  def create_date(date_args_arr)
    DateTime.new(*date_args_arr)
  end

  def create_track
    Track.new(start_date: self.date)
  end

  def txt_print
    text =''
    self.tracks.each_with_index do |track, index|
      text << "Track #{index+1}:\n"
      text << track.events_txt_print
      text << "\n"
    end
    write_file(text)
  end

  def write_file(text)
    begin
      file = File.open('./lib/output.txt', 'w')
      file.write(text)
    rescue IOError => e
      puts 'an error with writing the output file'
    ensure
      file.close unless file.nil?
    end
  end

end