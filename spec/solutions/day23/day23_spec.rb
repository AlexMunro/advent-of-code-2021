# frozen_string_literal: true

require "./solutions/day23/day23"

RSpec.describe Day23 do
  let(:day23) do
    described_class.new(
      [
        "#############",
        "#...........#",
        "###B#C#B#D###",
        "  #A#D#C#A#  ",
        "  #########  ",
      ]
    )
  end

  describe "#organisation_cost" do
    subject { day23.organisation_cost }

    it { is_expected.to eq 12_521 }
  end
end
