require_relative '../spec_helper'

describe Setup do

  describe '#initialize' do
    it 'it has a scheduler' do
      setup = Setup.new
      expect(setup.scheduler).not_to eq(nil)
    end

    it 'parses the input.txt file for talks' do
      setup = Setup.new
      expect(setup.scheduler.unplaced_talks.length).to eq(19)
    end
  end

  describe '#run' do
    it 'does a full run correctly' do
      setup = Setup.new
      setup.run
      expect(setup.scheduler.tracks.count).to eq(2)
      expect(setup.scheduler.tracks.collect{|track| track.talks}.flatten.count).to eq(19)
    end
  end

end