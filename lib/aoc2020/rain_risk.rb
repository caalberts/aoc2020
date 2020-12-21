# frozen_string_literal: true

module Aoc2020
  class RainRisk
    EAST = 'E'.freeze
    NORTH = 'N'.freeze
    WEST = 'W'.freeze
    SOUTH = 'S'.freeze
    LEFT = 'L'.freeze
    RIGHT = 'R'.freeze
    FORWARD = 'F'.freeze

    attr_reader :instructions

    def initialize(input)
      @instructions = input.split("\n").map(&method(:parse_instruction))
    end

    def part1
      ship = Ship.new
      instructions.each do |instruction|
        instruction.perform(ship)
      end

      ship.manhattan_distance
    end

    def part2
      ship = ShipWithWaypoint.new
      instructions.each do |instruction|
        instruction.perform(ship)
      end

      ship.manhattan_distance
    end

    class ShipWithWaypoint
      Waypoint = Struct.new(:x, :y)

      attr_reader :waypoint, :x, :y

      def initialize
        @waypoint = Waypoint.new(10, 1)
        @x = 0
        @y = 0
      end

      def manhattan_distance
        x.abs + y.abs
      end

      def move_north(value)
        @waypoint = Waypoint.new(waypoint.x, waypoint.y + value)
      end

      def move_south(value)
        @waypoint = Waypoint.new(waypoint.x, waypoint.y - value)
      end

      def move_east(value)
        @waypoint = Waypoint.new(waypoint.x + value, waypoint.y)
      end

      def move_west(value)
        @waypoint = Waypoint.new(waypoint.x - value, waypoint.y)
      end

      def move_forward(value)
        @x += waypoint.x * value
        @y += waypoint.y * value
      end

      def rotate_left(value)
        number_of_turns(value) do
          @waypoint = Waypoint.new(-waypoint.y, waypoint.x)
        end
      end

      def rotate_right(value)
        number_of_turns(value) do
          @waypoint = Waypoint.new(waypoint.y, -waypoint.x)
        end
      end

      def number_of_turns(value)
        turns = value / 90
        turns.times { yield }
      end
    end

    class Ship
      attr_reader :orientation, :x, :y

      def initialize
        @orientation = EAST
        @x = 0
        @y = 0
      end

      def manhattan_distance
        x.abs + y.abs
      end

      def move_north(value)
        @y += value
      end

      def move_south(value)
        @y -= value
      end

      def move_east(value)
        @x += value
      end

      def move_west(value)
        @x -= value
      end

      def move_forward(value)
        case orientation
        when NORTH then
          move_north(value)
        when SOUTH then
          move_south(value)
        when EAST then
          move_east(value)
        when WEST then
          move_west(value)
        else
          raise ArgumentError, 'Unknown orientation'
        end
      end

      def rotate_left(value)
        @orientation = rotate([NORTH, WEST, SOUTH, EAST], value)
      end

      def rotate_right(value)
        @orientation = rotate([NORTH, EAST, SOUTH, WEST], value)
      end

      private

      def rotate(orientations, value)
        current_orientation = orientations.index(orientation)
        num_turns = value / 90
        new_orientation_index = (num_turns + current_orientation) % orientations.length
        orientations[new_orientation_index]
      end
    end

    private

    MoveNorth = Struct.new(:value) do
      def perform(object)
        object.move_north(value)
      end
    end

    MoveEast = Struct.new(:value) do
      def perform(object)
        object.move_east(value)
      end
    end

    MoveWest = Struct.new(:value) do
      def perform(object)
        object.move_west(value)
      end
    end

    MoveSouth = Struct.new(:value) do
      def perform(object)
        object.move_south(value)
      end
    end

    RotateLeft = Struct.new(:value) do
      def perform(object)
        object.rotate_left(value)
      end
    end

    RotateRight = Struct.new(:value) do
      def perform(object)
        object.rotate_right(value)
      end
    end

    MoveForward = Struct.new(:value) do
      def perform(object)
        object.move_forward(value)
      end
    end

    def parse_instruction(string)
      match = string.match(/\A([NSEWLRF])(\d+)\z/)
      action = match[1]
      value = match[2].to_i

      case action
      when NORTH then
        MoveNorth.new(value)
      when SOUTH then
        MoveSouth.new(value)
      when EAST then
        MoveEast.new(value)
      when WEST then
        MoveWest.new(value)
      when FORWARD then
        MoveForward.new(value)
      when LEFT then
        RotateLeft.new(value)
      when RIGHT then
        RotateRight.new(value)
      else
        raise ArgumentError, 'unknown action'
      end
    end
  end
end
