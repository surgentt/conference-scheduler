require_relative '../spec_helper'

describe Scheduler do

  describe '#initialize' do
    it 'requires a conference and an array of talks' do
      talks = [Talk.new(name: 'Writing Fast Tests Against Enterprise Rails', minuets_long: 60)]
      scheduler = Scheduler.new({year: 2016, month: 5, day: 12, offset:'+4', talks: talks})
      expect(scheduler.unplaced_talks).to eq(talks)
      expect(scheduler.date.to_s).to eq('2016-05-12T00:00:00+04:00')
    end
  end

  describe '#run' do
    before do
      @talks = [Talk.new(name: 'Ruby is the Best Always', minuets_long: 45),
                Talk.new(name: 'Writing Fast Tests Against Enterprise Rails', minuets_long: 60)]
      @scheduler = Scheduler.new({year: 2016, month: 5, day: 12, offset:'+4', talks: @talks})
      @scheduler.run
    end

    it 'sets all unsorted_places' do
      expect(@scheduler.unplaced_talks.empty?).to eq(true)
    end
  end

end