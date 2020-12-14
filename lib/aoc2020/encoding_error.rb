# frozen_string_literal: true

module Aoc2020
  class EncodingError
    PREAMBLE_LENGTH = 25

    attr_reader :input

    def initialize(input)
      @input = input.split("\n").map(&:to_i)
    end

    def part1
      find_invalid_number(input)
    end

    def part2
      invalid_number = find_invalid_number(input)
      range = contiguous_range_to_sum(input, invalid_number, 0, 0, 0)
      range.min + range.max
    end

    private

    def contiguous_range_to_sum(numbers, target, low, high, sum)
      return numbers[low..high-1] if sum == target

      if sum < target
        contiguous_range_to_sum(numbers, target, low, high + 1, sum + numbers[high])
      else
        contiguous_range_to_sum(numbers, target, low + 1, high, sum - numbers[low])
      end
    end

    def find_invalid_number(input)
      sequence = input.each_cons(PREAMBLE_LENGTH + 1).find do |numbers|
        preamble = numbers[0..-2]
        next_number = numbers.last

        !summation?(preamble.sort, next_number)
      end

      sequence&.last
    end

    def summation?(numbers, target)
      left_cursor = 0
      right_cursor = numbers.length - 1

      until left_cursor >= right_cursor
        left_number = numbers[left_cursor]
        right_number = numbers[right_cursor]

        sum = left_number + right_number

        return true if sum == target

        if sum > target
          right_cursor -= 1
        else
          left_cursor += 1
        end
      end

      false
    end

  end
end
