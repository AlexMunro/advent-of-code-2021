# frozen_string_literal: true

require "./solutions/day05/day05"

RSpec.describe Day05 do
  let(:lines) do
    [
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2",
    ]
  end

  describe "#overlapping_points_for_horizontal_and_vertical_lines" do
    subject { described_class.new(lines).overlapping_points_for_horizontal_and_vertical_lines }

    it "includes the points where strictly horizontal and vertical lines overlap" do
      is_expected.to contain_exactly [0, 9], [1, 9], [2, 9], [3, 4], [7, 4]
    end
  end

  describe "#overlapping_points_for_all_lines" do
    subject { described_class.new(lines).overlapping_points_for_all_lines }

    it "includes the points where horizontal, vertical and diagonal lines overlap" do
      is_expected.to contain_exactly(
        [0, 9], [1, 9], [2, 2], [2, 9], [3, 4], [4, 4], [5, 3], [5, 5], [6, 4], [7, 1], [7, 3], [7, 4]
      )
    end
  end
end
