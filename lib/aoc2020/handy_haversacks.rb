# frozen_string_literal: true

require 'set'

module Aoc2020
  class HandyHaversacks
    attr_reader :lines

    def initialize(input)
      @lines = input.split("\n")
      parse_lines
      inverse_graph
    end

    def part1
      find_all_containers('shiny gold')
    end

    def part2
      parse_lines
      total_content('shiny gold')
    end

    def total_content(bag)
      count_contents(@contents, bag) - 1
    end

    def find_all_containers(bag)
      result = Set.new

      bfs(@inverse_contents, bag) do |container|
        result << container
      end

      result.length
    end

    private

    def count_contents(graph, start)
      graph[start].sum(1) do |qty, to|
        qty * count_contents(graph, to)
      end
    end

    def bfs(graph, start)
      queue = [start]
      seen = {}

      until queue.empty?
        from = queue.shift

        next if seen[from]

        graph[from].each do |_, to|
          yield to
          queue << to
        end

        seen[from] = true
      end
    end

    def inverse_graph
      @inverse_contents = Hash.new { |h, k| h[k] = [] }

      @contents.each do |container, contents|
        contents.each do |qty, content|
          @inverse_contents[content] << [qty, container]
        end
      end
    end

    def parse_lines
      @contents = {}

      lines.each do |line|
        bag_color, content_description = line.split(' bags contain ')

        @contents[bag_color] = parse_content(content_description)
      end
    end

    def parse_content(content)
      content.split(', ').each_with_object([]) do |inner_bag, result|
        match = inner_bag.match(/\A(\d+) ([a-z ]+) bags?\.?\z/)
        next unless match

        quantity = match[1].to_i
        color = match[2]

        result << [quantity, color]
      end
    end
  end
end
