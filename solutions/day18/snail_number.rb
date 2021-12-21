# frozen_string_literal: true

class SnailNumber
  attr_reader :pairs

  def initialize(numbers)
    @pairs = numbers[0]
    @subsequent_numbers = numbers[1..]
  end

  def sum
    @subsequent_numbers.each { |next_number| add(next_number) }
  end

  def add(number)
    @pairs = [pairs, number]
    reduce
  end

  def reduce
    while (explode_first = ready_to_explode?) || ready_to_split?
      if explode_first
        explode
      else
        split
      end
    end
  end

  def magnitude(pairs = @pairs)
    return pairs if pairs.is_a? Integer

    (3 * magnitude(pairs[0])) + (2 * magnitude(pairs[1]))
  end

  private

  def ready_to_explode?
    pairs.flatten(3) != pairs.flatten(4)
  end

  def ready_to_split?
    pairs.flatten.any? { |n| n >= 10 }
  end

  def explode
    explosion_position = find_explosion_position
    pair_at_position = element_at_position(explosion_position)

    if (left_number_position = regular_number_left_of(explosion_position))
      replace_element_at_position(
        left_number_position,
        element_at_position(left_number_position) + pair_at_position[0]
      )
    end

    if (right_number_position = regular_number_right_of(explosion_position))
      replace_element_at_position(
        right_number_position,
        element_at_position(right_number_position) + pair_at_position[1]
      )
    end

    replace_element_at_position(explosion_position, 0)
  end

  def split
    position = find_split_position
    value = element_at_position(position)
    replace_element_at_position(position, [(value / 2.0).floor, (value / 2.0).ceil])
  end

  def find_explosion_position
    (0..1).each do |first|
      (0..1).each do |second|
        (0..1).each do |third|
          (0..1).each do |fourth|
            return [first, second, third, fourth] if element_at_position([first, second, third, fourth]).is_a? Array
          end
        end
      end
    end

    puts "not found"
  end

  def find_split_position
    search_pos = leftmost_regular_number
    (search_pos = regular_number_right_of(search_pos)) until element_at_position(search_pos) >= 10
    search_pos
  end

  def element_at_position(position_stack)
    position_stack.inject(@pairs) { |pair_subset, next_position| pair_subset[next_position] }
  end

  def leftmost_regular_number
    position = [0]
    position.push(0) until element_at_position(position).is_a? Integer
    position
  end

  def regular_number_left_of(position)
    return if position.all?(&:zero?)

    left_position = position.dup

    last_turn = left_position.pop
    (last_turn = left_position.pop) until last_turn.nil? || last_turn == 1
    left_position.push(0)
    left_position.push(1) until element_at_position(left_position).is_a? Integer
    left_position
  end

  def regular_number_right_of(position)
    return if position.none?(&:zero?)

    right_position = position.dup
    last_turn = right_position.pop
    (last_turn = right_position.pop) until last_turn.nil? || last_turn.zero?
    right_position.push(1)
    right_position.push(0) until element_at_position(right_position).is_a? Integer
    right_position
  end

  def replace_element_at_position(position, element)
    element_at_position(position[...-1])[position.last] = element
  end
end
