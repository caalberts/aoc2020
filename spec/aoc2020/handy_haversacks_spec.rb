# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::HandyHaversacks do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    INPUT
  end

  describe '#part1' do
    it 'returns number of bag colours that contain at least one shiny gold bag' do
      expect(subject.part1).to eq(4)
    end
  end

  describe '#part2' do
    it 'returns number of bags contained in the given bag' do
      expect(subject.part2).to eq(32)
    end
  end
end
