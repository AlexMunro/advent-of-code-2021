# frozen_string_literal: true

# Models the surface level of a packet and its immediate children
class Packet
  HEADER_LENGTH = 6

  # Bit string starting at the current packet, though not necessarily ending at that packet
  def self.from_bits(bits)
    raise "Malformed packet #{bits}" if bits.length < HEADER_LENGTH

    if bits[3..5].to_i(2) == 4
      ValuePacket.new(bits)
    else
      OperatorPacket.new(bits)
    end
  end

  def initialize(bits)
    @bits = bits
  end

  def version
    @version ||= @bits[..2].to_i(2)
  end

  def version_sum
    version + children.sum(&:version_sum)
  end

  def children
    []
  end
end

# Packets that are associated with an operation and child packets
class OperatorPacket < Packet
  LENGTH_TYPE_LENGTH = 1
  SUBPACKET_COUNT_LENGTH = 11
  SUBPACKET_BIT_LENGTH = 15

  OPERATORS = {
    0 => ->(children) { children.sum(&:value) },
    1 => ->(children) { children.map(&:value).reduce(:*) },
    2 => ->(children) { children.map(&:value).min },
    3 => ->(children) { children.map(&:value).max },
    5 => ->(children) { children[0].value > children[1].value ? 1 : 0 },
    6 => ->(children) { children[0].value < children[1].value ? 1 : 0 },
    7 => ->(children) { children[0].value == children[1].value ? 1 : 0 },
  }.freeze

  def children
    @children ||=
      if child_count_known?
        parse_children_from_child_count
      else
        parse_children_from_bit_count
      end
  end

  def length
    @length ||=
      if child_count_known?
        HEADER_LENGTH + LENGTH_TYPE_LENGTH + SUBPACKET_COUNT_LENGTH + children.sum(&:length)
      else
        HEADER_LENGTH + LENGTH_TYPE_LENGTH + SUBPACKET_BIT_LENGTH + @bits[7...(7 + SUBPACKET_BIT_LENGTH)].to_i(2)
      end
  end

  def value
    OPERATORS[@bits[3..5].to_i(2)].call(children)
  end

  private

  def child_count_known?
    @child_count_known ||= @bits[6] == "1"
  end

  def child_count
    if child_count_known?
      @bits[7...(7 + SUBPACKET_COUNT_LENGTH)].to_i(2)
    else
      children.count
    end
  end

  def parse_children_from_child_count
    next_child_index = 18
    child_count.times.map do
      new_child = Packet.from_bits(@bits[next_child_index..])
      next_child_index += new_child.length
      new_child
    end
  end

  def parse_children_from_bit_count
    children = []
    next_child_index = 22
    while next_child_index < length
      children << Packet.from_bits(@bits[next_child_index..])
      next_child_index += children.last.length
    end
    children
  end
end

# Packets that do not have any children and contain literal values
class ValuePacket < Packet
  def value
    next_group_index = HEADER_LENGTH

    value = ""

    loop do
      value += @bits[next_group_index + 1..next_group_index + 4]
      break if @bits[next_group_index] == "0"

      next_group_index += 5
    end

    value.to_i(2)
  end

  def length
    next_group_index = HEADER_LENGTH
    next_group_index += 5 while @bits[next_group_index] == "1"
    next_group_index + 5
  end
end
