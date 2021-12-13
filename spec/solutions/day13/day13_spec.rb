# frozen_string_literal: true

require "./solutions/day13/day13"

RSpec.describe Day13 do
  let(:input) do
    [
      "6,10",
      "0,14",
      "9,10",
      "0,3",
      "10,4",
      "4,11",
      "6,0",
      "6,12",
      "4,1",
      "0,13",
      "10,12",
      "3,4",
      "3,0",
      "8,4",
      "1,10",
      "2,14",
      "8,10",
      "9,0",
      "",
      "fold along y=7",
      "fold along x=5",
    ]
  end

  describe "#dots_after_first_fold" do
    subject { described_class.from_strings(input).dots_after_first_fold }

    it { is_expected.to eq 17 }
  end

  describe "#message_after_all_folds" do
    subject { described_class.from_strings(input).message_after_all_folds }

    it "reveals a hidden message" do
      is_expected.to eq [
        "*****",
        "*   *",
        "*   *",
        "*   *",
        "*****",
      ]
    end
  end
end
