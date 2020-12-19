# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::AdapterArray do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    INPUT
  end

  describe '#part1' do
    it 'returns the product of number of 1 jolt differences and 3 jolt differences' do
      expect(subject.part1).to eq(220)
    end
  end

  describe '#part2' do
    it 'returns the number of possible adapter arrangements' do
      expect(subject.part2).to eq(19208)
    end
  end
end
