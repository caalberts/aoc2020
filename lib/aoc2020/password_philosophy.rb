# frozen_string_literal: true

module Aoc2020
  class PasswordPhilosophy
    attr_reader :input

    def initialize(input)
      @input = input.split("\n")
    end

    def part1
      entries = validate(input, OccurencePolicy)
      entries.count(true)
    end

    def part2
      entries = validate(input, PositionPolicy)
      entries.count(true)
    end

    private

    PATTERN = /\A(\d+)-(\d+) ([a-z]): ([a-z]+)\z/.freeze

    OccurencePolicy = Struct.new(:num1, :num2, :letter) do
      def validate(password)
        count = password.count(letter)
        (num1..num2).include?(count)
      end
    end

    PositionPolicy = Struct.new(:num1, :num2, :letter) do
      def validate(password)
        [num1, num2].one? do |position|
          password[position - 1] == letter
        end
      end
    end

    def validate(input, policy_class)
      input.map do |line|
        match = line.match(PATTERN)
        policy = policy_class.new(match[1].to_i, match[2].to_i, match[3])
        password = match[4]

        policy.validate(password)
      end
    end
  end
end
