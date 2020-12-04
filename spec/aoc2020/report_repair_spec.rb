require 'spec_helper'

RSpec.describe Aoc2020::ReportRepair do
  let(:input) do
    <<~INPUT
      1721
      979
      366
      299
      675
    INPUT
  end

  subject { described_class.new(input.split("\n")) }

  describe '#process' do
    it 'finds product of 3 integers that adds to 2020 and multiplies them' do
      expect(subject.process).to eq(241_861_950)
    end
  end
end
