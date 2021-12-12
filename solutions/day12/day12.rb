# frozen_string_literal: true

require_relative "../../utils/input/lines"

require "set"

class Day12
  extend Input::Lines

  def initialize(input_lines)
    @graph = {}

    input_lines.map { |line| line.split("-") }.each do |from, to|
      @graph[from] ||= []
      @graph[from].append(to)
      @graph[to] ||= []
      @graph[to].append(from)
    end
  end

  def self.part_one
    new(input).distinct_paths_without_repeats
  end

  def self.part_two
    new(input).distinct_paths_with_one_repeat
  end

  def distinct_paths_without_repeats
    distinct_paths(method(:next_node))
  end

  def distinct_paths_with_one_repeat
    distinct_paths(method(:next_node_with_one_repeat))
  end

  private

  def distinct_paths(neighbouring_node_method)
    frontier = [{ history: ["start"], small_visited: Set.new(["start"]) }]
    complete_paths = 0

    while (current_node = frontier.shift)
      @graph[current_node[:history].last].each do |neighbour|
        if neighbour == "end"
          complete_paths += 1
        elsif (neighbouring_node = neighbouring_node_method.call(current_node, neighbour))
          frontier.push(neighbouring_node)
        end
      end
    end

    complete_paths
  end

  def next_node(current_node, neighbour)
    return if current_node[:small_visited].include? neighbour

    history = current_node[:history] + [neighbour]
    small_visited = if neighbour == neighbour.downcase
                      current_node[:small_visited] + [neighbour]
                    else
                      current_node[:small_visited]
                    end

    { history:, small_visited: }
  end

  def next_node_with_one_repeat(current_node, neighbour)
    return if neighbour == "start"

    revisiting_small = current_node[:small_visited].include? neighbour
    return if revisiting_small && current_node[:already_revisited]

    history = current_node[:history] + [neighbour]
    small_visited = if neighbour == neighbour.downcase
                      current_node[:small_visited] + [neighbour]
                    else
                      current_node[:small_visited]
                    end

    { history:, small_visited:, already_revisited: current_node[:already_revisited] || revisiting_small }
  end
end
