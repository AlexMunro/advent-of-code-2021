# frozen_string_literal: true

class DisplayEntry
  def initialize(inputs, outputs)
    @inputs = inputs.map(&:chars).map(&:sort).map(&:join)
    @outputs = outputs.map(&:chars).map(&:sort).map(&:join)
  end

  def self.from_string(entry_string)
    new(*entry_string.split(" | ").map(&:split))
  end

  # Return the count of digits that must be 1, 4, 7 or 8
  def unique_segment_number_digits
    @outputs.filter { |digit| [2, 3, 4, 7].include?(digit.length) }.count
  end

  def sum_digits
    @outputs.map { |output| map_digits[output].to_s }.join.to_i
  end

  def map_digits
    corrupt_mapping = easily_identifiable_mapping
    corrupt_segments = easily_identifiable_segments(corrupt_mapping)
    segment_frequency_map = segment_frequency_map(corrupt_segments[:a])

    corrupt_segments[:f] = segment_frequency_map[9]
    corrupt_segments[:c] = segment_frequency_map[8]

    corrupt_mapping.merge!(five_segment_mapping(corrupt_segments))
    corrupt_mapping.merge!(six_segment_mapping(corrupt_segments))

    corrupt_mapping.invert # Final mapping of form string -> number
  end

  private

  def corrupt_digits
    (@inputs + @outputs).uniq
  end

  def words_by_length
    @words_by_length ||= corrupt_digits.unique.group_by(&:length)
  end

  def easily_identifiable_mapping
    {
      1 => corrupt_digits.find { |digit| digit.length == 2 },
      4 => corrupt_digits.find { |digit| digit.length == 4 },
      7 => corrupt_digits.find { |digit| digit.length == 3 },
      8 => corrupt_digits.find { |digit| digit.length == 7 },
    }
  end

  # Requires only the easily identifiable part of the mapping
  # The keys for the segments are in terms of the correct mapping,
  # while values are in terms of the corrupt mapping
  def easily_identifiable_segments(corrupt_mapping)
    {
      a: segment_a(corrupt_mapping),
      bd: segments_bd(corrupt_mapping),
      eg: segments_aeg(corrupt_mapping) - [segment_a(corrupt_mapping)],
    }
  end

  def segment_a(corrupt_mapping)
    (corrupt_mapping[7].chars - corrupt_mapping[1].chars).first
  end

  def segments_bd(corrupt_mapping)
    corrupt_mapping[4].chars - corrupt_mapping[1].chars
  end

  def segments_aeg(corrupt_mapping)
    corrupt_mapping[8].chars - corrupt_mapping[4].chars
  end

  # Work out by process of elimination which five-segment digits correspond to which numbers
  def five_segment_mapping(corrupt_segments)
    five_segment_digits = corrupt_digits.filter { |digit| digit.length == 5 }

    two_mapping = five_segment_digits.find { |digit| !digit.include? corrupt_segments[:f] }
    five_segment_digits.delete(two_mapping)

    three_mapping = five_segment_digits.find { |digit| corrupt_segments[:bd] & digit.chars != corrupt_segments[:bd] }
    five_segment_digits.delete(three_mapping)

    {
      2 => two_mapping,
      3 => three_mapping,
      5 => five_segment_digits.first,
    }
  end

  # Work out by process of elimination which six-segment digits correspond to which numbers
  def six_segment_mapping(corrupt_segments)
    six_segment_digits = corrupt_digits.filter { |digit| digit.length == 6 }

    six_mapping = six_segment_digits.find { |digit| !digit.include?(corrupt_segments[:c]) }
    six_segment_digits.delete(six_mapping)

    nine_mapping = six_segment_digits.find { |digit| corrupt_segments[:eg] & digit.chars != corrupt_segments[:eg] }
    six_segment_digits.delete(nine_mapping)

    {
      6 => six_mapping,
      9 => nine_mapping,
      0 => six_segment_digits.first
    }
  end

  # Excluding segment a since we already know it and this allows us to find segment c by length
  def segment_frequency_map(segment_a)
    ("a".."g").reject { |segment| segment == segment_a }.to_h do |char|
      [corrupt_digits.filter { |digit| digit.include? char }.count, char]
    end
  end
end
