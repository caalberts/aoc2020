# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::SeatingSystem do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    INPUT
  end

  describe '#part1' do
    it 'returns the final number of occupied seats' do
      expect(subject.part1).to eq(37)
    end
  end

  describe '#part2' do
    it 'returns  the final number of occupied seats' do
      expect(subject.part2).to eq(26)
    end
  end
end
