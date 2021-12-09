# frozen_string_literal: true

require "./solutions/day08/display_entry"

RSpec.describe DisplayEntry do
  let(:entry) do
    described_class.from_string(
      "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
    )
  end

  describe "#unique_segment_number_digits" do
    subject { entry.unique_segment_number_digits }

    it "returns the total count of 1s, 4s, 7s and 8s in the output" do
      is_expected.to eq 2
    end
  end

  describe "#sum_digits" do
    subject { entry.sum_digits }

    it "sums the digits according by solving the entry's corrupt mapping" do
      is_expected.to eq 8394
    end
  end

  describe "#map_digits" do
    let(:entry) do
      described_class.from_string(
        "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
      )
    end

    subject { entry.map_digits }

    it "determines which strings correspond to which digits" do
      is_expected.to eq(
        {
          "abcdefg" => 8,
          "acdfg" => 2,
          "bcdef" => 5,
          "abcdf" => 3,
          "abd" => 7,
          "abcdef" => 9,
          "bcdefg" => 6,
          "abef" => 4,
          "abcdeg" => 0,
          "ab" => 1,
        }
      )
    end
  end
end
