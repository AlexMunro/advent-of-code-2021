# frozen_string_literal: true

# Represents whether a set of velocities reaches the target area
# and if so, how high it goes
require_relative "../../utils/math_utils/numbers"

# Calculates the outcome of a single launch, given the initial component
# velocities and target grid.
class Launch
  attr_reader :x_target_area, :y_target_area, :x_velocity, :y_velocity

  RESULTS = [
    UNDERSHOOT = :undershoot,
    OVERSHOOT = :overshoot,
    VERTICAL_MISS = :vertical_miss,
    ON_TARGET = :on_target,
  ].freeze

  # Requires x_target_area and y_target_area as ranges
  def initialize(x_target_area, y_target_area, x_velocity, y_velocity)
    @x_target_area = x_target_area
    @y_target_area = y_target_area
    @x_velocity = x_velocity
    @y_velocity = y_velocity
  end

  def peak
    return 0 if @y_velocity <= 0

    MathUtils::Numbers.triangle_number(@y_velocity)
  end

  def result
    return UNDERSHOOT if furthest_horizontal_distance < x_target_area.begin

    final_x_pos, final_y_pos = final_position(x_velocity, y_velocity)

    return UNDERSHOOT if final_x_pos < x_target_area.begin
    return OVERSHOOT if final_x_pos > x_target_area.end
    return ON_TARGET if in_target_area?(final_x_pos, final_y_pos)

    VERTICAL_MISS
  end

  private

  def furthest_horizontal_distance
    MathUtils::Numbers.triangle_number(@x_velocity)
  end

  def final_position(x_velocity, y_velocity)
    x_pos = y_pos = 0

    while still_going_towards_target_area?(x_pos, y_pos)
      x_pos += x_velocity
      y_pos += y_velocity
      x_velocity -= 1 unless x_velocity.zero?
      y_velocity -= 1
    end

    [x_pos, y_pos]
  end

  def still_going_towards_target_area?(x_pos, y_pos)
    x_pos <= x_target_area.end &&
      y_pos >= y_target_area.begin &&
      !in_target_area?(x_pos, y_pos)
  end

  def in_target_area?(x_pos, y_pos)
    x_target_area.include?(x_pos) && y_target_area.include?(y_pos)
  end
end
