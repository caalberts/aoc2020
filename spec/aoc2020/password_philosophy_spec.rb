# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::PasswordPhilosophy do
  let(:input) do
    <<~INPUT
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    INPUT
  end

  describe '#part1' do
    subject { described_class.new(input) }

    it 'checks that given letter appears within the given range' do
      expect(subject.part1).to eq(2)
    end
  end

  describe '#part2' do
    subject { described_class.new(input) }

    it 'counts number of valid password according to their policies' do
      expect(subject.part2).to eq(1)
    end
  end
end
