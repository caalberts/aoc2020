# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::RainRisk do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      F10
      N3
      F7
      R90
      F11
    INPUT
  end

  describe '#part1' do
    it 'returns the Manhattan distance of the ship from its starting position' do
      expect(subject.part1).to eq(25)
    end
  end

  describe Aoc2020::RainRisk::Ship do
    subject(:ship) { described_class.new }

    describe '#move_north' do
      it 'moves north by value' do
        expect { ship.move_north(2) }.to change { ship.y }.by(2)
        expect { ship.move_north(2) }.not_to change { ship.x }
        expect { ship.move_north(2) }.not_to change { ship.orientation }
      end
    end

    describe '#move_south' do
      it 'moves south by value' do
        expect { ship.move_south(2) }.to change { ship.y }.by(-2)
        expect { ship.move_south(2) }.not_to change { ship.x }
        expect { ship.move_south(2) }.not_to change { ship.orientation }
      end
    end

    describe '#move_east' do
      it 'moves east by value' do
        expect { ship.move_east(2) }.to change { ship.x }.by(2)
        expect { ship.move_east(2) }.not_to change { ship.y }
        expect { ship.move_east(2) }.not_to change { ship.orientation }
      end
    end

    describe '#move_west' do
      it 'moves west by value' do
        expect { ship.move_west(2) }.to change { ship.x }.by(-2)
        expect { ship.move_west(2) }.not_to change { ship.y }
        expect { ship.move_west(2) }.not_to change { ship.orientation }
      end
    end

    describe '#rotate_left' do
      it 'rotates by the given number of degrees' do
        ship.rotate_left(90)

        expect(ship.x).to eq(0)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::NORTH)

        ship.rotate_left(180)

        expect(ship.x).to eq(0)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::SOUTH)
      end
    end

    describe '#rotate_right' do
      it 'rotates by the given number of degrees' do
        ship.rotate_right(180)

        expect(ship.x).to eq(0)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::WEST)

        ship.rotate_right(90)

        expect(ship.x).to eq(0)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::NORTH)
      end
    end

    describe '#move_forward' do
      it 'moves in the current orientation by given value' do
        ship.move_forward(3)

        expect(ship.x).to eq(3)
        expect(ship.y).to eq(0)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::EAST)

        ship.rotate_left(90)
        ship.move_forward(4)

        expect(ship.x).to eq(3)
        expect(ship.y).to eq(4)
        expect(ship.orientation).to eq(Aoc2020::RainRisk::NORTH)
      end
    end

    describe '#manhattan_distance' do
      it 'returns the total of northsouth and eastwest displacement' do
        ship.move_forward(3)
        ship.rotate_left(90)
        ship.move_forward(4)
        ship.move_south(10)

        expect(ship.manhattan_distance).to eq(9)
      end
    end
  end

  describe '#part2' do
    it 'returns the Manhattan distance of the ship from its starting position' do
      expect(subject.part2).to eq(286)
    end
  end

  describe Aoc2020::RainRisk::ShipWithWaypoint do
    subject(:ship) { described_class.new }

    describe '#waypoint' do
      it 'starts at 10 units east and 1 unit north' do
        waypoint = ship.waypoint

        expect(waypoint.y).to eq(1)
        expect(waypoint.x).to eq(10)
      end
    end


    describe '#move_north' do
      it 'moves waypoint north by value' do
        expect { ship.move_north(2) }.to change { ship.waypoint.y }.by(2)
        expect { ship.move_north(2) }.not_to change { ship.waypoint.x }
      end
    end

    describe '#move_south' do
      it 'moves waypoint south by value' do
        expect { ship.move_south(2) }.to change { ship.waypoint.y }.by(-2)
        expect { ship.move_south(2) }.not_to change { ship.waypoint.x }
      end
    end

    describe '#move_east' do
      it 'moves waypoint east by value' do
        expect { ship.move_east(2) }.not_to change { ship.waypoint.y }
        expect { ship.move_east(2) }.to change { ship.waypoint.x }.by(2)
      end
    end

    describe '#move_west' do
      it 'moves waypoint west by value' do
        expect { ship.move_west(2) }.not_to change { ship.waypoint.y }
        expect { ship.move_west(2) }.to change { ship.waypoint.x }.by(-2)
      end
    end

    describe '#rotate_left' do
      it 'rotates waypoint around the ship by the given number of degrees' do
        ship.rotate_left(90)

        expect(ship.waypoint.x).to eq(-1)
        expect(ship.waypoint.y).to eq(10)

        ship.rotate_left(90)

        expect(ship.waypoint.x).to eq(-10)
        expect(ship.waypoint.y).to eq(-1)

        ship.rotate_left(90)

        expect(ship.waypoint.x).to eq(1)
        expect(ship.waypoint.y).to eq(-10)

        ship.rotate_left(90)

        expect(ship.waypoint.x).to eq(10)
        expect(ship.waypoint.y).to eq(1)

        ship.rotate_left(180)

        expect(ship.waypoint.x).to eq(-10)
        expect(ship.waypoint.y).to eq(-1)
      end
    end

    describe '#rotate_right' do
      it 'rotates waypoint around the ship by the given number of degrees' do
        ship.rotate_right(90)

        expect(ship.waypoint.x).to eq(1)
        expect(ship.waypoint.y).to eq(-10)

        ship.rotate_right(90)

        expect(ship.waypoint.x).to eq(-10)
        expect(ship.waypoint.y).to eq(-1)

        ship.rotate_right(90)

        expect(ship.waypoint.x).to eq(-1)
        expect(ship.waypoint.y).to eq(10)

        ship.rotate_right(90)

        expect(ship.waypoint.x).to eq(10)
        expect(ship.waypoint.y).to eq(1)

        ship.rotate_right(180)

        expect(ship.waypoint.x).to eq(-10)
        expect(ship.waypoint.y).to eq(-1)
      end
    end

    describe '#move_forward' do
      it 'moves towards the waypoint by multiple of the given value' do
        ship.move_forward(3)

        expect(ship.x).to eq(30)
        expect(ship.y).to eq(3)
      end
    end

    describe '#manhattan_distance' do
      it 'returns the total of northsouth and eastwest displacement' do
        ship.move_forward(3)

        expect(ship.manhattan_distance).to eq(33)
      end
    end
  end
end
