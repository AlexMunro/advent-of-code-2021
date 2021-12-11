# frozen_string_literal: true

require "./solutions/day11/day11"

RSpec.describe Day11 do

  let(:example) do
    [
      [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
      [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
      [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
      [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
      [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
      [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
      [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
      [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
      [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
      [5, 2, 8, 3, 7, 5, 1, 5, 2, 6],
    ]
  end

  describe "#total_flashes" do
    let(:simple_example) do
      [
        [1, 1, 1, 1, 1],
        [1, 9, 9, 9, 1],
        [1, 9, 1, 9, 1],
        [1, 9, 9, 9, 1],
        [1, 1, 1, 1, 1],
      ]
    end

    it "counts the number of flashes that happen over the given number of steps" do
      expect(described_class.new(simple_example).total_flashes(1)).to eq 9
      expect(described_class.new(simple_example).total_flashes(2)).to eq 9

      expect(described_class.new(example).total_flashes(10)).to eq 204
      expect(described_class.new(example).total_flashes(100)).to eq 1656
    end
  end

  describe "#flash_sync_step" do
    it "returns the step at which all octopedes simultaneously flash" do
      expect(described_class.new(example).flash_sync_step).to eq 195
    end
  end
end
