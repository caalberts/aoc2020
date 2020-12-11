# frozen_string_literal: true

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

  subject { described_class.new(input) }

  describe '#part1' do
    it 'finds product of 2 integers that adds to 2020 and multiplies them' do
      expect(subject.part1).to eq(514579)
    end
  end

  describe '#part2' do
    it 'finds product of 3 integers that adds to 2020 and multiplies them' do
      expect(subject.part2).to eq(241_861_950)
    end
  end
end
