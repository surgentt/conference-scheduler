require_relative '../spec_helper'

describe Track do

  describe '#initialize' do
    it 'has :start_time, :lunch_start, :lunch_end, :networking_window on initialization' do
      track = Track.new(start_date: DateTime.new)
      expect(track.start_time.hour).to eq(9)
    end
  end

end