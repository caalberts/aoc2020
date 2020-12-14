# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::HandheldHalting do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    INPUT
  end

  describe '#part1' do
    it 'returns the value of accumulator before an instruction is executed a second time' do
      success, value = subject.part1

      expect(success).to be(false)
      expect(value).to eq(5)
    end
  end

  describe '#part2' do
    it 'fixes the program and returns the accumulator at the end of the program' do
      success, value = subject.part2

      expect(success).to be(true)
      expect(value).to eq(8)
    end
  end
end
