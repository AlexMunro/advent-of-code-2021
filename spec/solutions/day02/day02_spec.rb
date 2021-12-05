# frozen_string_literal: true

require "./solutions/day02/day02"

RSpec.describe Day02 do
  let(:instructions) do
    [
      ["forward", 5],
      ["down", 5],
      ["forward", 8],
      ["up", 3],
      ["down", 8],
      ["forward", 2],
    ]
  end

  describe ".find_depth" do
    subject { described_class.find_depth(instructions) }

    it "adds the amounts of down commands and subtracts the amounts of up commands" do
      is_expected.to eq 10
    end
  end

  describe ".find_horizontal_pos" do
    subject { described_class.find_horizontal_pos(instructions) }

    it "adds the amounts of forward commands" do
      is_expected.to eq 15
    end
  end

  describe ".get_depth_and_pos_with_aim" do
    subject { described_class.get_depth_and_pos_with_aim(instructions) }

    it "calculates depth and pos based on the changing aim and amount of forward movement" do
      is_expected.to eq [60, 15]
    end
  end
end
