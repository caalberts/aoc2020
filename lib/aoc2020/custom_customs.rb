# frozen_string_literal: true

require 'strscan'

module Aoc2020
  class CustomCustoms
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def process
      group_answers = read_groups(input)
      group_answers.map { |g| count_yes(g) }.sum
    end

    def read_groups(string)
      scanner = CustomScanner.new(string)

      group_answers = []

      until scanner.done?
        group_answer = scanner.scan
        group_answers << group_answer
      end

      group_answers
    end

    def count_yes(group_answer)
      group_answer.map { |g| g.split('') }.inject(:&).count
    end

    class CustomScanner
      GROUP_SEPARATOR = "\n\n"

      attr_reader :scanner

      def initialize(string)
        @scanner = StringScanner.new(string)
      end

      def done?
        scanner.eos?
      end

      def scan
        return if scanner.eos?

        group_answer = []

        until scanner.eos? || scanner.skip(/#{GROUP_SEPARATOR}/)
          if scanner.scan(/([a-z]+)/)
            person_answer = scanner.captures.first
            group_answer << person_answer
          else
            scanner.pos += 1
          end
        end

        group_answer
      end
    end
  end
end
