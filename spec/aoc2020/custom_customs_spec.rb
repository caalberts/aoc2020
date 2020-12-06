require 'spec_helper'

RSpec.describe Aoc2020::CustomCustoms do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    INPUT
  end

  describe '#process' do
    it 'sums number of questions answered yes across all groups' do
      expect(subject.process).to eq(6)
    end
  end

  describe '#count_yes' do
    let(:group_answer) { %w[abcx abcy abcz] }

    it 'counts number of question answered yes by everyone in a group' do
      expect(subject.count_yes(group_answer)).to eq(3)
    end
  end
end
