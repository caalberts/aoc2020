# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::TobogganTrajectory do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    INPUT
  end

  describe '#process' do
    it 'counts product of trees encountered along the way with speed 1, 3, 5, 7, 0.5' do
      expect(subject.process).to eq(336)
    end
  end

  describe '#count_trees' do
    it 'counts product of trees encountered along the way with speed right 3, down 1' do
      expect(subject.count_trees(described_class::Speed.new(3, 1))).to eq(7)
    end

    it 'counts product of trees encountered along the way with speed 0.5' do
      expect(subject.count_trees(described_class::Speed.new(1, 2))).to eq(2)
    end
  end
end
