# frozen_string_literal: true

module Aoc2020
  class Solver
    PROBLEMS = {
      1 => ReportRepair,
      2 => PasswordPhilosophy,
      3 => TobogganTrajectory,
      4 => PassportProcessing,
      5 => BinaryBoarding,
      6 => CustomCustoms,
      7 => HandyHaversacks,
      8 => HandheldHalting,
      9 => EncodingError,
    }.freeze

    attr_reader :day, :part

    def initialize(day: 1, part: 1)
      @day = day
      @part = part
    end

    def solve
      PROBLEMS.fetch(day).new(input).public_send("part#{part}")
    rescue KeyError
      warn "Unimplemented problem for day #{day}"
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
