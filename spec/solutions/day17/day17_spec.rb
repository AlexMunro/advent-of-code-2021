# frozen_string_literal: true

require "./solutions/day17/day17"

RSpec.describe Day17 do
  let(:day17) { described_class.new("target area: x=20..30, y=-10..-5") }

  describe "#peak" do
    subject { day17.peak }

    it { is_expected.to eq 45 }
  end

  describe "#valid_velocity_combination_count" do
    subject { day17.valid_velocity_combination_count }

    it { is_expected.to eq 112 }
  end
end
