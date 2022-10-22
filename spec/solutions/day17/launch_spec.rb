# frozen_string_literal: true

require "./solutions/day17/launch"
require "debug"

RSpec.describe Launch do
  let(:launch) { described_class.new(x_target_range, y_target_range, x_velocity, y_velocity) }

  let(:x_target_range) { 20..30 }
  let(:y_target_range) { -10..-5 }

  describe "#peak" do
    subject(:peak) { launch.peak }

    let(:x_velocity) { 6 }

    context "with y velocity greater than zero" do
      let(:y_velocity) { 9 }

      it "is the y position at the point where velocity decreases to zero" do
        expect(peak).to eq 45
      end
    end

    context "with y velocity of zero or less" do
      let(:y_velocity) { -10 }

      it "is always the starting y position" do
        expect(peak).to be_zero
      end
    end
  end

  describe "#result" do
    subject { launch.result }

    context "with a winning set of initial velocities" do
      let(:x_velocity) { 7 }
      let(:y_velocity) { 2 }

      it { is_expected.to eq Launch::ON_TARGET }
    end

    context "with velocities that go too far" do
      let(:x_velocity) { 17 }
      let(:y_velocity) { -4 }

      it { is_expected.to eq Launch::OVERSHOOT }
    end

    context "with cowardly velocities" do
      let(:x_velocity) { 1 }
      let(:y_velocity) { 1 }

      it { is_expected.to eq Launch::UNDERSHOOT }
    end
  end
end
