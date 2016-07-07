class Setup
  attr_reader :scheduler

  def initialize
    talks = create_talks_from_txt
    @scheduler = Scheduler.new(year: 2016, month: 6, day: 10, offset: '+4', talks: talks)
  end

  def run
    self.scheduler.run
  end

  private

  def create_talks_from_txt
    File.open('./lib/input.txt', 'r') do |f|
      f.readlines.collect do |line|
        Talk.new(talk_line_to_args(line))
      end
    end
  end

  def talk_line_to_args(line)
    # Common Ruby Errors 45min
    # Rails for Python Developers lightning
    talk_arr = line.split(/(\d+)/)
    hash = {name: talk_arr[0].strip}
    hash[:minuets_long] = talk_arr[1].to_i if talk_arr[1]
    hash
  end

end
