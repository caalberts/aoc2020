module Aoc2020
  class PasswordPhilosophy
    Policy = Struct.new(:positions, :letter)

    attr_reader :input

    def initialize(input)
      @input = input
    end

    def process
      entries = parse(input)
      entries.count do |policy, password|
        valid_password?(policy, password)
      end
    end

    PATTERN = /\A(\d+)-(\d+) ([a-z]): ([a-z]+)\z/.freeze

    def parse(input)
      input.map do |line|
        match = line.match(PATTERN)
        policy = Policy.new([match[1].to_i, match[2].to_i], match[3])
        password = match[4]

        [policy, password]
      end
    end

    def valid_password?(policy, password)
      count = policy.positions.count do |position|
        password[position - 1] == policy.letter
      end

      count == 1
    end
  end
end
