# frozen_string_literal: true

require "./solutions/day06/day06"

RSpec.describe Day06 do
  describe ".children_after_days" do
    let(:initial_fish) { [3, 4, 3, 1, 2] }

    it "returns the total count of population after n days" do
      expect(described_class.new.children_after_days(initial_fish, 0)).to eq 5
      expect(described_class.new.children_after_days(initial_fish, 5)).to eq 10
      expect(described_class.new.children_after_days(initial_fish, 18)).to eq 26
      expect(described_class.new.children_after_days(initial_fish, 80)).to eq 5934
      expect(described_class.new.children_after_days(initial_fish, 256)).to eq 26_984_457_539
    end
  end

  describe "#self_and_descendant_count" do
    it "counts the fish and all of its children after n days" do
      expect(described_class.new.self_and_descendant_count(3, 0)).to eq 1
      expect(described_class.new.self_and_descendant_count(3, 3)).to eq 1
      expect(described_class.new.self_and_descendant_count(3, 4)).to eq 2
      expect(described_class.new.self_and_descendant_count(3, 10)).to eq 2
      expect(described_class.new.self_and_descendant_count(3, 11)).to eq 3
    end
  end
end
