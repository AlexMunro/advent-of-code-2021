# frozen_string_literal: true

require "./solutions/day07/day07"

RSpec.describe Day07 do
  let(:day07) { Day07.new([16, 1, 2, 0, 4, 2, 7, 1, 2, 14]) }

  describe "#least_fuel_required" do
    subject { day07.least_fuel_required(fuel_method) }

    context "with linear fuel" do
      let(:fuel_method) { :linear_fuel_required_for_position }

      it "finds the least fuel required to align on any point" do
        is_expected.to eq 37
      end
    end

    context "with superlinear fuel" do
      let(:fuel_method) { :superlinear_fuel_required_for_position }

      it "finds the least fuel required to align on any point" do
        is_expected.to eq 168
      end
    end
  end

  describe "#linear_fuel_required_for_position" do
    it "sums the difference between each starting position and the required position" do
      expect(day07.linear_fuel_required_for_position(1)).to eq 41
      expect(day07.linear_fuel_required_for_position(2)).to eq 37
      expect(day07.linear_fuel_required_for_position(3)).to eq 39
      expect(day07.linear_fuel_required_for_position(10)).to eq 71
    end
  end

  describe "#superlinear_fuel_required_for_position" do
    it "sums the fuel required for each starting point to reach the position " do
      expect(day07.superlinear_fuel_required_for_position(2)).to eq 206
      expect(day07.superlinear_fuel_required_for_position(5)).to eq 168
    end
  end
end
