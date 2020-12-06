# frozen_string_literal: true

module Aoc2020
  class ReportRepair
    DESIRED_SUM = 2020

    def initialize(input)
      @input = input.split("\n").map(&:to_i).sort
    end

    def process
      find_multiplication(3, @input, DESIRED_SUM)
    end

    def find_multiplication(num_factors, input, desired_sum)
      if num_factors > 2
        input.each_with_index do |i, idx|
          result = find_multiplication(num_factors - 1, input[idx + 1..-1], desired_sum - i)
          return i * result if result
        end
      end

      left_cursor = 0
      right_cursor = input.length - 1

      until left_cursor > right_cursor
        left_value = input[left_cursor]
        right_value = input[right_cursor]

        sum = left_value + right_value

        return left_value * right_value if sum == desired_sum

        if sum > desired_sum
          right_cursor -= 1
        else
          left_cursor += 1
        end
      end
    end
  end
end
