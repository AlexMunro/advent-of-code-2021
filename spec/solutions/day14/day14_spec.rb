# frozen_string_literal: true

require "./solutions/day14/day14"

RSpec.describe Day14 do
  let(:day14) do
    described_class.from_strings(
      [
        "NNCB",
        "",
        "CH -> B",
        "HH -> N",
        "CB -> H",
        "NH -> C",
        "HB -> C",
        "HC -> B",
        "HN -> C",
        "NN -> C",
        "BH -> H",
        "NC -> B",
        "NB -> B",
        "BN -> B",
        "BB -> N",
        "BC -> B",
        "CC -> N",
        "CN -> C",
      ]
    )
  end

  describe "#difference_between_most_and_least_common_element" do
    it "finds the difference between the most and least common elements at 10 passes of rule applications" do
      expect(day14.difference_between_most_and_least_common_element(10)).to eq 1588
    end
  end

  describe "#apply_rules" do
    it "further expands the polymer with each pass of rule applications" do
      expect(day14.apply_rules).to eq "NCNBCHB".chars.each_cons(2).map(&:join).tally
      expect(day14.apply_rules).to eq "NBCCNBBBCBHCB".chars.each_cons(2).map(&:join).tally
      expect(day14.apply_rules).to eq "NBBBCNCCNBBNBNBBCHBHHBCHB".chars.each_cons(2).map(&:join).tally
      expect(day14.apply_rules).to eq "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
        .chars.each_cons(2).map(&:join).tally
    end
  end
end
