# frozen_string_literal: true

require 'strscan'

module Aoc2020
  class PassportProcessing
    Passport = Struct.new(:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid)

    BYR = 'byr'
    IYR = 'iyr'
    EYR = 'eyr'
    HGT = 'hgt'
    HCL = 'hcl'
    ECL = 'ecl'
    PID = 'pid'
    CID = 'cid'

    attr_reader :input

    def initialize(input)
      @input = input
    end

    def part1
      passports = read_passports(input)
      passports.count { |passport| has_required_fields?(passport) }
    end

    def part2
      passports = read_passports(input)
      passports.count { |passport| has_valid_fields?(passport) }
    end

    def read_passports(string)
      scanner = PassportScanner.new(string)

      passports = []

      until scanner.done?
        passport = scanner.scan
        passports << passport
      end

      passports
    end

    def has_required_fields?(passport)
      required = [BYR, IYR, EYR, HGT, HCL, ECL, PID]
      required.all? { |field| !passport.public_send(field).nil? }
    end

    def has_valid_fields?(passport)
      valid_byr?(passport.byr) &&
        valid_iyr?(passport.iyr) &&
        valid_eyr?(passport.eyr) &&
        valid_hgt?(passport.hgt) &&
        valid_hcl?(passport.hcl) &&
        valid_ecl?(passport.ecl) &&
        valid_pid?(passport.pid)
    end

    private

    class PassportScanner
      ALLOWED_FIELDS = [BYR, IYR, EYR, HGT, HCL, ECL, PID, CID].freeze
      PASSPORT_SEPARATOR = "\n\n"

      attr_reader :scanner

      def initialize(string)
        @scanner = StringScanner.new(string)
      end

      def done?
        scanner.eos?
      end

      def scan
        return if scanner.eos?

        valid_field_patterns = ALLOWED_FIELDS.join('|')

        passport = Passport.new

        until scanner.eos? || scanner.skip(/#{PASSPORT_SEPARATOR}/)
          if scanner.scan(/(#{valid_field_patterns}):(#?\w+)/)
            field = scanner.captures[0]
            value = scanner.captures[1]
            passport.send("#{field}=", value)
          else
            scanner.pos += 1
          end
        end

        passport
      end
    end

    def valid_byr?(byr)
      return false unless byr

      year = byr.to_i
      year >= 1920 && year <= 2002
    end

    def valid_iyr?(iyr)
      return false unless iyr

      year = iyr.to_i
      year >= 2010 && year <= 2020
    end

    def valid_eyr?(eyr)
      return false unless eyr

      year = eyr.to_i
      year >= 2020 && year <= 2030
    end

    def valid_hgt?(hgt)
      match = hgt&.match(/\A(\d+)(in|cm)\z/)

      return false unless match

      height = match[1].to_i
      unit = match[2]

      if unit == 'cm'
        height >= 150 && height <= 193
      else
        height >= 59 && height <= 76
      end
    end

    def valid_hcl?(hcl)
      return false unless hcl

      hcl.match(/\A#[a-f0-9]{6}\z/)
    end

    def valid_ecl?(ecl)
      return false unless ecl

      ecl.match(/\Aamb|blu|brn|gry|grn|hzl|oth\z/)
    end

    def valid_pid?(pid)
      return false unless pid

      pid.match(/\A\d{9}\z/)
    end
  end
end
