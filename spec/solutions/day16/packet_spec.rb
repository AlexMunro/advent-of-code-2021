# frozen_string_literal: true

require "./solutions/day16/packet"

RSpec.describe Packet do
  describe "operator packets" do
    let(:packet) { described_class.from_bits("00111000000000000110111101000101001010010001001000000000") }

    describe "#version" do
      subject { packet.version }

      it { is_expected.to be 1 }
    end

    describe "#version_sum" do
      subject { packet.version_sum }

      it "sums its own version number and that of all enclosed packets" do
        is_expected.to be 9
      end
    end

    describe "#value" do
      subject { packet.value }

      it "performs the relevant operation (<) on the operand packets" do
        is_expected.to eq 1
      end
    end

    describe "#children" do
      subject { packet.children }

      it { expect(subject.length).to eq 2 }
    end

    describe "#length" do
      subject { packet.length }

      it "should cover itself and enclosed packets but not any padding at the end" do
        is_expected.to eq 49
      end
    end
  end

  describe "literal packets" do
    let(:packet) { described_class.from_bits("110100101111111000101000") }

    describe "#version" do
      subject { packet.version }

      it { is_expected.to be 6 }
    end

    describe "#version_sum" do
      subject { packet.version_sum }

      it "is the same as the version of the packet" do
        is_expected.to be packet.version
      end
    end

    describe "#value" do
      subject { packet.value }

      it "provides the literal value" do
        is_expected.to eq 2021
      end
    end

    describe "#length" do
      subject { packet.length }

      it "covers its own length but not any padding on the end" do
        is_expected.to eq 21
      end
    end

    describe "#children" do
      subject { packet.children }

      it { is_expected.to be_empty }
    end
  end
end
