module Aoc2020
  class Solver
    PROBLEMS = {
      1 => ReportRepair
    }.freeze

    attr_reader :day

    def initialize(day: 1)
      @day = day
    end

    def solve
      PROBLEMS[day].new(input).process
    end

    def verify_cookie
      Config.cookie || raise('Cookie required to authenticate with AOC 2020')
    end

    def input
      verify_cookie
      Aoc2020::Input.new(day: day).fetch
    end
  end
end
