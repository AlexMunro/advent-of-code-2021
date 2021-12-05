# frozen_string_literal: true

require "./solutions/day04/bingo_board"

RSpec.describe BingoBoard do
  describe "#bingo?" do
    let(:sheet) do
      described_class.new [
        [22, 13, 17, 11, 0],
        [8,  2, 23,  4, 24],
        [21, 9, 14, 16, 7],
        [6, 10, 3, 18, 5],
        [1, 12, 20, 15, 19],
      ]
    end

    before { called_numbers.each { |n| sheet.call(n) } }

    subject { sheet.bingo? }

    context "when an entire row has been called" do
      let(:called_numbers) { [21, 9, 14, 16, 7] }

      it { is_expected.to eq true }
    end

    context "when an entire column has been called" do
      let(:called_numbers) { [13, 2, 9, 10, 12] }

      it { is_expected.to eq true }
    end

    context "when there is no complete line of called numbers" do
      let(:called_numbers) { [13, 21, 1, 15, 24, 11] }

      it { is_expected.to eq false }
    end
  end
end
