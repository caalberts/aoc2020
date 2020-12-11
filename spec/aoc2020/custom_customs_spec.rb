# frozen_string_literal: true

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

  describe '#part1' do
    it 'sums the number of questions that anyone in a group answered yes' do
      expect(subject.part1).to eq(11)
    end
  end

  describe '#part2' do
    it 'sums number of questions answered yes across all groups' do
      expect(subject.part2).to eq(6)
    end
  end

  describe '#count_yes' do
    let(:group_answer) { %w[abcx abcy abcz] }

    it 'counts number of question answered yes by everyone in a group' do
      expect(subject.count_all_yes(group_answer)).to eq(3)
    end
  end
end
