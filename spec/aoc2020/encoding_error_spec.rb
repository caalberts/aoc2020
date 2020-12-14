# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::EncodingError do
  subject { described_class.new(input) }

  before do
    stub_const("#{described_class}::PREAMBLE_LENGTH", 5)
  end

  let(:input) do
    <<~INPUT
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    INPUT
  end

  describe '#part1' do
    it 'returns the first invalid number' do
      expect(subject.part1).to eq(127)
    end
  end

  describe '#part2' do
    it 'returns the sum of lowest and highest in the range that adds to invalid number' do
      expect(subject.part2).to eq(62)
    end
  end
end
