# frozen_string_literal: true

require "./solutions/day01/day01"

RSpec.describe Day01 do
  let(:measurements) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

  describe ".number_of_improvements" do
    subject { described_class.number_of_improvements(measurements) }

    it "counts the number of times each measurement was higher than its predecessor" do
      is_expected.to eq 7
    end
  end

  describe ".number_of_group_improvements" do
    subject { described_class.number_of_group_improvements(measurements) }

    it "counts the number of times each triple of measurements was higher than its predecessor" do
      is_expected.to eq 5
    end
  end
end
