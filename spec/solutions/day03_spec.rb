# frozen_string_literal: true

require "./solutions/day03/day03"

RSpec.describe Day03 do
  let(:day03) { Day03.new(input) }
  let(:input) do
    [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010",
    ]
  end

  describe "#gamma" do
    subject { day03.gamma }

    it "returns the number comprised of each of the most common values per bit" do
      is_expected.to eq "10110".to_i(2)
    end
  end

  describe "#epsilon" do
    subject { day03.epsilon }

    it "returns the complement of the gamma value" do
      is_expected.to eq "01001".to_i(2)
    end
  end

  describe "#oxygen_generation" do
    subject { day03.oxygen_generation }

    it "returns the value which contains the most of the most common values per bit" do
      is_expected.to eq "10111".to_i(2)
    end
  end

  describe "#co2_rating" do
    subject { day03.co2_rating }

    it "returns the value which contains the least of the most common values per bit" do
      is_expected.to eq "01010".to_i(2)
    end
  end
end
