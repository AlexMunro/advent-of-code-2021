# frozen_string_literal: true

require "./solutions/day25/day25"

RSpec.describe Day25 do
  let(:day25) do
    described_class.new(
      [
        "v...>>.vv>",
        ".vv>>.vv..",
        ">>.>v>...v",
        ">>v>>.>.v.",
        "v>v.vv.v..",
        ">.>>..v...",
        ".vv..>.>v.",
        "v.v..>>v.v",
        "....v..v.>",
      ]
    )
  end

  describe "#steps_to_steady_state" do
    subject { day25.steps_to_steady_state }

    it { is_expected.to eq 58 }
  end
end
