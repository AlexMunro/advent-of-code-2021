# frozen_string_literal: true

require_relative "../../utils/input/lines"
require_relative "./rotation_matrices"
require "set"
require "debug"
require "matrix"

class Day19
  extend Input::Lines

  MAX_DISTANCE = 1_000
  MIN_SHARED = 12

  def self.part_one
    new(input).beacon_count.filter
  end

  def self.part_two

  end

  def initialize(lines)
    @scanners = parse_scanners(lines)
  end

  def beacon_count
    locate_scanners
    @beacons.count
  end

  private

  def parse_scanners(lines)
    scanners = [Set.new]
    lines.each do |line|
      if line.empty?
        scanners << Set.new
      else
        scanners.last << line.split(",").map(&:to_i) unless line.start_with?("--- scanner")
      end
    end
    scanners
  end

  # Return a hash of scanner IDs mapped to their offset and orientation from scanner 0
  def locate_scanners
    scanner_locs_and_orientations = {
      0 => {
        loc: [0, 0, 0],
        orientation: Matrix.identity(3),
      },
    }

    queue = [0]

    until queue.empty?
      base_scanner_idx = queue.shift

      @scanners.each_with_index do |scanner, scanner_idx|
        next if scanner_locs.keys.include?(scanner_idx)

        next unless (relative_offset, relative_orientation = find_offset_and_orientation(@scanners[base_scanner_idx], scanner))

        # Turn the relative_offset/orientation into an offset/orientation from @scanners[0]
        scanner_locs_and_orientations[scanner_idx] =  {
          loc: offset_point(relative_offset, negate(@scanners[base_scanner_idx])),
          orientation: scanner[:orientation] * relative_orientation
        }

        queue.push(scanner_idx)
        return scanner_locs if scanner_locs.length == @scanners.length
      end
    end

    raise "Complete solution not found. Only able to locate: #{scanner_locs}"
  end

  # Return the offset if a valid one is found
  def find_offset_and_orientation(first_scanner, second_scanner)
    testable_pairs = first_scanner.flat_map do |first_point|
      second_scanner.map { |second_point| [first_point, second_point] }
    end.filter { |pair| distance_between_points(*pair) <= MAX_DISTANCE }

    # what the hell do you mean I need to rotate it too

    debugger

    testable_offsets.find { |offset| find_fitting_rotation(first_scanner, second_scanner, offset) }
  end

  # Test whether a proposed offset holds for the minimum number of points between two scanners
  # and if so, return the necessary rotation
  def find_fitting_rotatation(first_scanner, second_scanner, offset)
    ROTATION_MATRICES.each do |rotation_matrix|
      common_beacon_count = 0

      # If there are points that are hypothetically in range of both scanners, they must both match
      next unless first_scanner.all? do |point|
        translated_point = offset_point(point, offset)
        common_beacon = second_scanner.include?(translated_point)
        common_beacon_count += 1 if common_beacon

        common_beacon || within_max_distance_of_origin?(point)
      end

      next unless second_scanner.all? do |point|
        translated_point = offset_point(point, negate(offset))
        common_beacon = first_point.include?(translated_point)

        common_beacon || within_max_distance_of_origin?(point)
      end

      return rotation_matrix if 54common_beacon_count >= MIN_SHARED
    end

    false
  end

  def distance_between_points(first_point, second_point)
    first_point.each_with_index.map { |p, i| (p - second_point[i])**2 }.sum**0.5
  end

  def offset_point(point, offset_vector)
    point.zip(offset_vector).map(&:sum)
  end

  def offset_vector_between_points(first_point, second_point)
    first_point.zip(second_point).map { |first_coord, second_coord| second_coord - first_coord }
  end

  def negate(vector)
    vector.map(&:-@)
  end

  def within_max_distance_of_origin?(point)
    distance_between_points([0, 0, 0], point) > MAX_DISTANCE
  end
end
