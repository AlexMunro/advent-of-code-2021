# frozen_string_literal: true

# A single possible configuration of the states
class PodsState
  attr_accessor :rooms, :hallway

  # Only to be used when creating the inital state. Duplicate in all other cases.
  def initialize(rows)
    @rooms = 4.times.map { [] } # stacks to represent the contents of rooms

    rows.reverse.each do |line|
      line.each_with_index do |char, room|
        @rooms[room] << char
      end
    end

    @hallway = 10.times.map { nil }
  end

  # pairs of [pods state, cost of current move]
  def neighbours
    neighbours = []

    # moves from hallway to room
    @hallway.each_with_index.reject { |char, _| char.nil? }.each do |current_char, next_hallway_item_pos|
      next unless room_only_contains_appropriate?(current_char)

      current_char = @hallway[next_hallway_item_pos]

      target_room_index = char_to_stack_index(current_char)
      target_hallway_index = room_to_hallway_index(target_room_index)
      accessible_hallway_points = accessible_hallway_spots_from(next_hallway_item_pos)

      hallway_cost = (next_hallway_item_pos - target_hallway_index).abs
      room_cost = 2 - @rooms[target_room_index].length
      cost = (hallway_cost + room_cost) * cost_per_movement(@hallway[next_hallway_item_pos])

      if accessible_hallway_points.include?(target_hallway_index - 1) || accessible_hallway_points.include?(target_hallway_index + 1)
        neighbours.push(
          [
            clone.tap do |cloned|
              cloned.hallway[next_hallway_item_pos] = nil
              cloned.rooms[target_room_index].push(current_char)
            end , cost
          ]
        )
      end
    end

    # moves from room to hallway
    @rooms.each_with_index do |room, index|
      next if room.all? { |item| char_to_stack_index(item) == index }
      item_to_consider = room.last

      hallway_index = room_to_hallway_index(index)

      room_cost = 3 - @rooms[index].length

      accessible_hallway_spots_from(hallway_index).each do |destination_index|
        hallway_cost = (destination_index - hallway_index).abs
        cost = (hallway_cost + room_cost) * cost_per_movement(item_to_consider)

        neighbours.push(
          [
            clone.tap do |cloned|
              cloned.hallway[destination_index] = item_to_consider
              cloned.rooms[index].pop
            end, cost
          ]
        )
      end
    end

    neighbours
  end

  def ==(other)
    @rooms == other.instance_variable_get("@rooms") &&
      @hallway == other.instance_variable_get("@hallway")
  end

  def goal?
    @hallway.all?(&:nil?) &&
      @rooms.each_with_index.all? do |room, idx|
        room.none? { |char| char_to_stack_index(char) != idx }
      end
  end

  private

  def clone
    self.dup.tap do |clone|
      clone.rooms = clone.rooms.map(&:dup)
      clone.hallway = clone.hallway.dup
    end
  end

  # 0 = a, 1 = b, 2 = c, 3 = d
  def char_to_stack_index(char)
    char.downcase.ord - "a".ord
  end

  def room_to_hallway_index(room_index)
    2 * (room_index + 1)
  end

  # hardcoding because lazy, these are the spots immediately outside rooms
  def illegal_hallway_parking_spots
    [2, 4, 6, 8]
  end

  def cost_per_movement(char)
    10 ** char_to_stack_index(char)
  end

  def accessible_hallway_spots_from(hallway_index)
    lower_bound = ((hallway_index - 1).downto(0).find { |idx| !@hallway[idx].nil? } || -1 ) + 1
    upper_bound = ((hallway_index + 1).upto(10).find { |idx| !@hallway[idx].nil? } || @hallway.length ) - 1

    lower_bound.upto(upper_bound).to_a - illegal_hallway_parking_spots
  end

  def room_only_contains_appropriate?(room_char)
    correct_index = char_to_stack_index(room_char)
    @rooms[correct_index].all? { |item| char_to_stack_index(item) == correct_index }
  end
end
