require_relative '../spec_helper'

describe Relax do

  describe '#initialize' do
    it 'args can be set during initialization' do
      lunch = Relax.new({ name: 'Lunch', minuets_long: 60, start_time: DateTime.new.change({hour: 12}), end_time: DateTime.new.change({hour: 13})})
      expect(lunch.name).to eq('Lunch')
      expect(lunch.type).to eq('relax')
    end

  end

end