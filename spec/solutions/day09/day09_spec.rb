# frozen_string_literal: true

require "./solutions/day09/day09"

RSpec.describe Day09 do
  let(:day09) do
    described_class.new(
      [
        [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
        [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
        [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
        [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
        [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
      ]
    )
  end

  describe "#sum_risk_of_low_points" do
    subject { day09.sum_risk_of_low_points }

    it { is_expected.to eq 15 }
  end

  describe "#largest_three_basins_size" do
    subject { day09.largest_three_basins_size }

    it { is_expected.to eq 1134 }
  end
end
