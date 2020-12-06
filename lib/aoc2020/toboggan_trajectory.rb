# frozen_string_literal: true

module Aoc2020
  class TobogganTrajectory
    TREE = '#'

    Speed = Struct.new(:right, :down)

    attr_reader :input

    def initialize(input)
      @input = input.split("\n")
    end

    def process
      speeds = [
        Speed.new(1, 1),
        Speed.new(3, 1),
        Speed.new(5, 1),
        Speed.new(7, 1),
        Speed.new(1, 2)
      ]

      trees = speeds.map { |speed| count_trees(speed) }
      trees.inject(:*)
    end

    def count_trees(speed)
      i = 0
      j = 0
      trees = 0

      until i >= input.length - 1
        i += speed.down
        j = (j + speed.right) % input.first.length

        trees += 1 if input[i][j] == TREE
      end

      trees
    end
  end
end
