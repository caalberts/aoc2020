require 'faraday'

module Aoc2020
  class Input
    attr_reader :day

    def initialize(day: 1)
      @day = day
    end

    def fetch
      response = Faraday.get(uri, {}, headers)
      response.body.split("\n")
    end

    private

    def uri
      "https://adventofcode.com/2020/day/#{day}/input"
    end

    def headers
      { 'Cookie' => "session=#{Config.cookie}" }
    end
  end
end
