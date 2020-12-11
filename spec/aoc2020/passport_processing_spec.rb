# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Aoc2020::PassportProcessing do
  subject { described_class.new(input) }

  let(:input) { '' }

  describe '#part1' do
    let(:input) do
      <<~INPUT
        ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
        byr:1937 iyr:2017 cid:147 hgt:183cm

        iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
        hcl:#cfa07d byr:1929

        hcl:#ae17e1 iyr:2013
        eyr:2024
        ecl:brn pid:760753108 byr:1931
        hgt:179cm

        hcl:#cfa07d eyr:2025 pid:166559648
        iyr:2011 ecl:brn hgt:59in
      INPUT
    end

    it 'counts number of valid passport with required fields' do
      expect(subject.part1).to eq(2)
    end
  end

  describe '#part2' do
    context 'with valid passport' do
      let(:input) do
        <<~INPUT
          pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
          hcl:#623a2f
          
          eyr:2029 ecl:blu cid:129 byr:1989
          iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm
          
          hcl:#888785
          hgt:164cm byr:2001 iyr:2015 cid:88
          pid:545766238 ecl:hzl
          eyr:2022
          
          iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
        INPUT
      end

      it 'counts number of valid passports' do
        expect(subject.part2).to eq(4)
      end
    end

    context 'with invalid passports' do
      let(:input) do
        <<~INPUT
          eyr:1972 cid:100
          hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

          iyr:2019
          hcl:#602927 eyr:1967 hgt:170cm
          ecl:grn pid:012533040 byr:1946

          hcl:dab227 iyr:2012
          ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

          hgt:59cm ecl:zzz
          eyr:2038 hcl:74454a iyr:2023
          pid:3556412378 byr:2007
        INPUT
      end

      it 'counts number of valid passports' do
        expect(subject.part2).to eq(0)
      end
    end
  end

  describe '#read_passports' do
    context 'multi line single passport' do
      let(:input) do
        <<~INPUT
          ecl:gry pid:860033327
          byr:1937 iyr:2017
        INPUT
      end

      it 'returns passport with provided parameters' do
        passports = subject.read_passports(input)

        expect(passports[0].ecl).to eq('gry')
        expect(passports[0].pid).to eq('860033327')
        expect(passports[0].byr).to eq('1937')
        expect(passports[0].iyr).to eq('2017')
      end
    end

    context 'multi line multiple passports' do
      let(:input) do
        <<~INPUT
          hcl:#cfa07d eyr:2025 pid:166559648
          iyr:2011 ecl:brn hgt:59in

          ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
          byr:1937 iyr:2017 cid:147 hgt:183cm
        INPUT
      end

      it 'returns passports with provided parameters' do
        passports = subject.read_passports(input)

        passport1 = passports[0]
        expect(passport1.hcl).to eq('#cfa07d')
        expect(passport1.eyr).to eq('2025')
        expect(passport1.pid).to eq('166559648')
        expect(passport1.iyr).to eq('2011')
        expect(passport1.ecl).to eq('brn')
        expect(passport1.hgt).to eq('59in')

        passport2 = passports[1]
        expect(passport2.ecl).to eq('gry')
        expect(passport2.pid).to eq('860033327')
        expect(passport2.eyr).to eq('2020')
        expect(passport2.hcl).to eq('#fffffd')
        expect(passport2.byr).to eq('1937')
        expect(passport2.iyr).to eq('2017')
        expect(passport2.cid).to eq('147')
        expect(passport2.hgt).to eq('183cm')
      end
    end

    context 'with unknown identifiers' do
      let(:input) do
        <<~INPUT
          ecl:gry foo:bar
          byr:1937 iyr:2017
        INPUT
      end

      it 'ignores unknown identifiers' do
        passports = subject.read_passports(input)

        expect(passports[0].ecl).to eq('gry')
        expect(passports[0].byr).to eq('1937')
        expect(passports[0].iyr).to eq('2017')
      end
    end
  end

  describe '#valid_passport?' do
    let(:byr) { '1937' }
    let(:iyr) { '2017' }
    let(:eyr) { '2025' }
    let(:hgt) { '183cm' }
    let(:hcl) { '#fffffd' }
    let(:ecl) { 'gry' }
    let(:pid) { '860033327' }
    let(:cid) { '147' }

    let(:passport) { described_class::Passport.new(byr, iyr, eyr, hgt, hcl, ecl, pid, cid) }

    context 'with all information' do
      it 'is valid' do
        expect(subject.has_valid_fields?(passport)).to be_truthy
      end
    end

    context 'without cid' do
      let(:cid) { nil }

      it 'is valid' do
        expect(subject.has_valid_fields?(passport)).to be_truthy
      end
    end

    context 'without any other field' do
      let(:byr) { nil }

      it 'is invalid' do
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without any other field' do
      let(:byr) { nil }

      it 'is invalid' do
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid birth year' do
      it 'is invalid' do
        passport.byr = '1919'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.byr = '2003'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid issue year' do
      it 'is invalid' do
        passport.iyr = '2009'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.iyr = '2021'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid expiration year' do
      it 'is invalid' do
        passport.eyr = '2019'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.eyr = '2031'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid height in cm' do
      it 'is invalid' do
        passport.hgt = '149cm'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.hgt = '194cm'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid height in inches' do
      it 'is invalid' do
        passport.hgt = '58in'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.hgt = '77in'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid height unit' do
      it 'is invalid' do
        passport.hgt = '58mm'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid hair colour' do
      it 'is invalid' do
        passport.hcl = '#1234567'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.hcl = '#zzzzzz'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid eye colour' do
      it 'is invalid' do
        passport.ecl = 'abc'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.ecl = 'xyz'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end

    context 'without valid passport id' do
      it 'is invalid' do
        passport.pid = '1234'
        expect(subject.has_valid_fields?(passport)).to be_falsey

        passport.pid = '1234567890'
        expect(subject.has_valid_fields?(passport)).to be_falsey
      end
    end
  end
end
