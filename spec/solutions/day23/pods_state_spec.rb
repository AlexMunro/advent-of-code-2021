# frozen_string_literal: true

require "./solutions/day23/pods_state"

RSpec.describe PodsState do

  describe "#initialize" do
    subject(:pods_state) do
      described_class.new(
        [
          "BCBD".chars,
          "ADCA".chars,
        ]
      )
    end

    it "assigns pods to the correct spaces" do
      expect(pods_state.instance_variable_get("@rooms")).to eq([
        ["A", "B"], ["D", "C"], ["C", "B"], ["A", "D"],
      ])
    end
  end

  describe "#neighbours" do
    subject { pods_state.neighbours }

    let(:pods_state) do
      described_class.new(
        [
          "BCBD".chars,
          "ADCA".chars,
        ]
      )
    end

    before do
      # Attain this state:
      #
      # #############
      # #.....C...B.#
      # ###B#.#.#D###
      #   #A#D#C#A#
      #   #########
      #

      rooms = pods_state.instance_variable_get("@rooms")
      rooms[1].pop
      rooms[2].pop

      hallway = pods_state.instance_variable_get("@hallway")
      hallway[5] = "C"
      hallway[9] = "B"

      hallway_stack = pods_state.instance_variable_get("@hallway_stack")
      hallway_stack.push(9)
      hallway_stack.push(5)
    end

    it "includes options for moving to the hallway and moving from the hallway to the rooms" do
      # Options include:
      #  - popping the B in the A room and going to any of [0, 1, 3]
      #  - popping the D in the B room and going to any of [0, 1, 3]
      #  - popping the D in the D room and going only to 7
      #  - putting the C in the hallway into its room

      expect(subject.length).to eq 8

      expect(subject.map(&:last)).to eq [
        10**2 * (1 + 1), # C from 5 -> C
        10**1 * (2 + 1), # B from A -> 0
        10**1 * (1 + 1), # B from A -> 1
        10**1 * (1 + 1), # B from A -> 3
        10**3 * (4 + 2), # D from B -> 0
        10**3 * (3 + 2), # D from B -> 1
        10**3 * (1 + 2), # D from B -> 3
        10**3 * (1 + 1), # D from D -> 7
      ]
    end

    it "does not change any internal state" do
      expect { subject }.not_to(
        change {
          pods_state.instance_variable_get("@rooms").hash +
            pods_state.instance_variable_get("@hallway").hash
        }
      )
    end
  end
end
