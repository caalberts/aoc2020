# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::BinaryBoarding do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
    INPUT
  end

  describe '#find_seat' do
    it 'finds seat based on boarding pass' do
      expect(subject.find_seat('BFFFBBFRRR').id).to eq(567)
      expect(subject.find_seat('FFFBBBFRRR').id).to eq(119)
      expect(subject.find_seat('BBFFBBFRLL').id).to eq(820)
    end
  end

  describe '#find_row' do
    it 'determines row from given sequence' do
      expect(subject.find_row('FBFBBFF')).to eq(44)
    end
  end

  describe '#find_col' do
    it 'determines column from given sequence' do
      expect(subject.find_col('RLR')).to eq(5)
    end
  end
end
