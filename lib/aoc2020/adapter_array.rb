# frozen_string_literal: true

module Aoc2020
  class AdapterArray
    attr_reader :sequence

    def initialize(input)
      adapters = input.split("\n").map(&:to_i).sort
      supply = 0
      device = adapters.last + 3
      @sequence = adapters.unshift(supply).push(device)
      @tribonacci = {}
    end

    def part1
      count = count_diff(sequence)

      count[1] * count[3]
    end

    def count_diff(sequence)
      sequence.each_cons(2).each_with_object(Hash.new(0)) do |(from, to), count|
        diff = to - from
        count[diff] += 1
      end
    end

    def tribonacci(n)
      @tribonacci[n] ||= case n
                         when 0 then
                           1
                         when 1 then
                           1
                         when 2 then
                           2
                         else
                           tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
                         end
    end

    def part2
      one_diffs = 0
      result = 1
      sequence.each_cons(2) do |array|
        diff = array[1] - array[0]
        if diff == 1
          one_diffs += 1
        else
          result *= tribonacci(one_diffs)
          one_diffs = 0
        end
      end

      result
    end
  end
end
