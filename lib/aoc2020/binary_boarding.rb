# frozen_string_literal: true

module Aoc2020
  class BinaryBoarding
    attr_reader :input

    ROWS = (0..127).to_a
    COLS = (0..7).to_a

    Seat = Struct.new(:row, :col) do
      def id
        row * 8 + col
      end
    end

    def initialize(input)
      @input = input.split("\n")
    end

    def part1
      input.map { |boarding_pass| find_seat(boarding_pass).id }.max
    end

    def part2
      seat_ids = input.map { |boarding_pass| find_seat(boarding_pass).id }.sort
      seat_ids.each_with_index do |seat_id, idx|
        next_seat = seat_id + 1

        return next_seat if next_seat != seat_ids[idx + 1]
      end
    end

    def find_seat(boarding_pass)
      row_sequence = boarding_pass[0...-3]
      col_sequence = boarding_pass[-3..-1]

      row = find_row(row_sequence)
      col = find_col(col_sequence)

      Seat.new(row, col)
    end

    def find_row(row_sequence)
      binary_partition(row_sequence.split(''), ROWS, ROWS.first, ROWS.last, lower_half: 'F')
    end

    def find_col(col_sequence)
      binary_partition(col_sequence.split(''), COLS, COLS.first, COLS.last, lower_half: 'L')
    end

    def binary_partition(sequence, range, low, high, lower_half:)
      return range[low] if low == high

      next_half = sequence.shift
      midpoint = (low + high) / 2

      if next_half == lower_half
        binary_partition(sequence, range, low, midpoint, lower_half: lower_half)
      else
        binary_partition(sequence, range, midpoint + 1, high, lower_half: lower_half)
      end
    end
  end
end
