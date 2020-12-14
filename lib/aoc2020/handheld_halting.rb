# frozen_string_literal: true

module Aoc2020
  class HandheldHalting
    attr_reader :instructions

    def initialize(input)
      input = input.split("\n")
      @instructions = parse_instructions(input)
    end

    def part1
      program = Program.new(instructions)
      program.run[1]
    end

    def part2
      instructions.each_with_index do |instruction, idx|
        next if instruction.is_a?(Acc)

        dup = instructions.map(&:clone)
        dup[idx] = swap(dup[idx])
        program = Program.new(dup)

        success, value = program.run

        return value if success
      end

      nil
    end

    private

    Nop = Struct.new(:value)
    Acc = Struct.new(:value)
    Jmp = Struct.new(:value)

    class Program
      def initialize(instructions)
        @instructions = instructions
        @executed = Array.new(instructions.size)
        @accumulator = 0
        @cursor = 0
      end

      def run
        until executed[cursor] || cursor > instructions.size - 1
          execute(instructions[cursor])
        end

        [completed?, accumulator]
      end

      private

      attr_accessor :accumulator, :cursor
      attr_reader :instructions, :executed

      def execute(instruction)
        track(cursor)

        case instruction
        when Nop
          advance(1)
        when Acc
          accumulate(instruction.value)
          advance(1)
        when Jmp
          advance(instruction.value)
        else
          raise ArgumentError, 'Unknown instruction'
        end
      end

      def advance(amount)
        self.cursor += amount
      end

      def accumulate(amount)
        self.accumulator += amount
      end

      def track(index)
        executed[index] = true
      end

      def completed?
        cursor >= instructions.size
      end
    end

    def swap(instruction)
      case instruction
      when Nop then Jmp.new(instruction.value)
      when Jmp then Nop.new(instruction.value)
      end
    end

    def instruction_class_for(instruction)
      case instruction
      when 'nop' then Nop
      when 'acc' then Acc
      when 'jmp' then Jmp
      else
        raise ArgumentError, 'Unrecognized instruction'
      end
    end

    def parse_instructions(input)
      input.map do |line|
        instruction, value = line.split(' ')
        instruction_class_for(instruction).new(value.to_i)
      end
    end
  end
end
