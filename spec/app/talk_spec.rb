require_relative '../spec_helper'

describe Talk do

  describe '#initialize' do
    it 'args can be set during initialization' do
      talk = Talk.new(name: 'Writing Fast Tests Against Enterprise Rails', minuets_long: 60)
      expect(talk.name).to eq('Writing Fast Tests Against Enterprise Rails')
      expect(talk.minuets_long).to eq(60)
      expect(talk.type).to eq('talk')
    end

    it 'if no minuets long were passed, assume a lightning talk' do
      talk = Talk.new(name: 'Writing Fast Tests Against Enterprise Rails')
      expect(talk.minuets_long).to eq(5)
    end
  end

end