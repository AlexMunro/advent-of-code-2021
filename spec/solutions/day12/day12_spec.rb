# frozen_string_literal: true

require "./solutions/day12/day12"

RSpec.describe Day12 do
  let(:small_example) { %w[start-A start-b A-c A-b b-d A-end b-end] }

  let(:medium_example) do
    %w[dc-end HN-start start-kj dc-start dc-HN LN-dc HN-end kj-sa kj-HN kj-dc]
  end

  let(:large_example) do
    %w[fs-end he-DX fs-he start-DX pj-DX end-zg zg-sl zg-pj pj-he
       RW-he fs-DX pj-RW zg-RW start-pj he-WI zg-he pj-fs start-RW]
  end

  describe "#distinct_paths_without_repeats" do
    it "counts the number of different paths that don't repeatedly visit any small caves" do
      expect(described_class.new(small_example).distinct_paths_without_repeats).to eq 10
      expect(described_class.new(medium_example).distinct_paths_without_repeats).to eq 19
      expect(described_class.new(large_example).distinct_paths_without_repeats).to eq 226
    end
  end

  describe "#distinct_paths_with_one_repeat" do
    it "counts the number of different paths that visit one small cave up to twice" do
      expect(described_class.new(small_example).distinct_paths_with_one_repeat).to eq 36
      expect(described_class.new(medium_example).distinct_paths_with_one_repeat).to eq 103
      expect(described_class.new(large_example).distinct_paths_with_one_repeat).to eq 3509
    end
  end
end
