require 'spec_helper'

RSpec.describe Aoc2020::PasswordPhilosophy do
  let(:input) do
    <<~INPUT
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    INPUT
  end

  describe '#process' do
    subject { described_class.new(input) }

    it 'counts number of valid password according to their policies' do
      expect(subject.process).to eq(1)
    end
  end
end
