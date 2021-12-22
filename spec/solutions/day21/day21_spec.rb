# frozen_string_literal: true

require "./solutions/day21/day21"

RSpec.describe Day21 do
  let(:day21) { described_class.new(4, 8) }

  describe "#practice_game" do
    subject { day21.practice_game }

    it { is_expected.to eq 739_785 }
  end
<<<<<<< HEAD
=======

  xdescribe "#quantum_game" do
    subject { day21.quantum_game }

    it { is_expected.to eq 444_356_092_776_315 }
  end
>>>>>>> Day 21 part one
end
