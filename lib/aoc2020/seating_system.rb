# frozen_string_literal: true

module Aoc2020
  class SeatingSystem
    FLOOR = '.'.freeze
    EMPTY = 'L'.freeze
    OCCUPIED = '#'.freeze

    attr_reader :seats

    def initialize(input)
      @seats = input.split("\n").map do |row|
        row.split('')
      end
    end

    def part1
      WaitingArea.new(seats, AdjacentNeighbours, tolerance: 4).fill
    end

    def part2
      WaitingArea.new(seats, VisibleNeighbours, tolerance: 5).fill
    end

    private

    class WaitingArea
      attr_reader :seats, :neighbour_finder, :tolerance

      def initialize(seats, neighbour_finder, tolerance:)
        @seats = seats
        @neighbour_finder = neighbour_finder.new(seats)
        @tolerance = tolerance
      end

      def fill
        fill_seats
        count_occupied_seats
      end

      def fill_seats
        loop do
          cycle
          break if no_change?
          update
        end
      end

      def count_occupied_seats
        occupied_seats_in_row = seats.map do |row|
          row.count { |seat| seat == OCCUPIED }
        end

        occupied_seats_in_row.sum
      end

      def no_change?
        @changes.empty?
      end

      def cycle
        @changes = []

        seats.each_with_index do |row, i|
          row.each_with_index do |col, j|
            if should_change?(i, j)
              @changes << [i, j]
            end
          end
        end
      end

      def update
        @changes.each do |row, col|
          switch(row, col)
        end
      end

      def switch(row, col)
        case seats[row][col]
        when OCCUPIED then
          seats[row][col] = EMPTY
        when EMPTY then
          seats[row][col] = OCCUPIED
        else
          nil
        end
      end

      def should_change?(row, col)
        neighbours = neighbour_finder.neighbours(seats, row, col)
        occupied_seats = neighbours.count { |seat| seat == OCCUPIED }

        if seats[row][col] == EMPTY
          occupied_seats == 0
        elsif seats[row][col] == OCCUPIED
          occupied_seats >= tolerance
        end
      end

      def neighbours(row, col)
        neighbour_finder.neighbours(seats, row, col)
      end
    end

    class AdjacentNeighbours
      attr_reader :seats, :num_rows, :num_cols

      def initialize(seats)
        @seats = seats
        @num_rows = seats.length
        @num_cols = seats.first.length
      end

      def neighbours(seats, row, col)
        neighbours = []

        neighbours << seats[row - 1][col - 1] if row >= 1 && col >= 1
        neighbours << seats[row - 1][col] if row >= 1
        neighbours << seats[row - 1][col + 1] if row >= 1 && col < num_cols - 1
        neighbours << seats[row][col - 1] if col >= 1
        neighbours << seats[row][col + 1] if col < num_cols - 1
        neighbours << seats[row + 1][col - 1] if row < num_rows - 1 && col >= 1
        neighbours << seats[row + 1][col] if row < num_rows - 1
        neighbours << seats[row + 1][col + 1] if row < num_rows - 1 && col < num_cols - 1

        neighbours
      end
    end

    class VisibleNeighbours
      Direction = Struct.new(:vertical, :horizontal)

      Upleft = Direction.new(-1, -1)
      Up = Direction.new(-1, 0)
      Upright = Direction.new(-1, 1)
      Left = Direction.new(0, -1)
      Right = Direction.new(0, 1)
      Downleft = Direction.new(1, -1)
      Down = Direction.new(1, 0)
      Downright = Direction.new(1, 1)

      DIRECTIONS = [
        Upleft,
        Up,
        Upright,
        Left,
        Right,
        Downleft,
        Down,
        Downright
      ].freeze

      attr_reader :seats, :num_rows, :num_cols, :visible_seats

      def initialize(seats)
        @seats = seats
        @num_rows = seats.length
        @num_cols = seats.first.length
        @visible_seats = Hash.new { |h, k| h[k] = [] }

        map_neighbours
      end

      def look_in_direction(row, col, direction)
        case direction
        when Upleft then return unless row > 0 && col > 0
        when Up then return unless row > 0
        when Upright then return unless row > 0 && col < num_cols - 1
        when Left then return unless col > 0
        when Right then return unless col < num_cols - 1
        when Downleft then return unless row < num_rows - 1 && col > 0
        when Down then return unless row < num_rows - 1
        when Downright then return unless row < num_rows - 1 && col < num_cols - 1
        end

        next_row = row + direction.vertical
        next_col = col + direction.horizontal
        seat = seats[next_row][next_col]

        return [next_row, next_col] unless seat == FLOOR

        look_in_direction(next_row, next_col, direction)
      end

      def map_neighbours
        seats.each_with_index do |row, i|
          row.each_with_index do |_, j|
            visible_seats[[i, j]] << look_in_direction(i, j, Upleft)
            visible_seats[[i, j]] << look_in_direction(i, j, Upright)
            visible_seats[[i, j]] << look_in_direction(i, j, Up)
            visible_seats[[i, j]] << look_in_direction(i, j, Left)
            visible_seats[[i, j]] << look_in_direction(i, j, Right)
            visible_seats[[i, j]] << look_in_direction(i, j, Downleft)
            visible_seats[[i, j]] << look_in_direction(i, j, Down)
            visible_seats[[i, j]] << look_in_direction(i, j, Downright)

            visible_seats[[i, j]].compact!
          end
        end
      end

      def neighbours(seats, row, col)
        visible_seats[[row, col]].map do |i, j|
          seats[i][j]
        end
      end
    end
  end
end
