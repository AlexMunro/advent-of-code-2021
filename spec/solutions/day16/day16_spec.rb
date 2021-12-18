# frozen_string_literal: true

require "./solutions/day16/day16"

RSpec.describe Day16 do
  describe "#sum_version_numbers" do
    it "sums the version numbers of all contained packets" do
      expect(described_class.new("8A004A801A8002F478").sum_version_numbers).to eq 16
      expect(described_class.new("620080001611562C8802118E34").sum_version_numbers).to eq 12
      expect(described_class.new("C0015000016115A2E0802F182340").sum_version_numbers).to eq 23
      expect(described_class.new("A0016C880162017C3686B18A3D4780").sum_version_numbers).to eq 31
    end
  end

  describe "#evaluate" do
    it "performs all the operations and returns the value of the outermost packet" do
      expect(described_class.new("C200B40A82").evaluate).to eq 3
      expect(described_class.new("04005AC33890").evaluate).to eq 54
      expect(described_class.new("880086C3E88112").evaluate).to eq 7
      expect(described_class.new("CE00C43D881120").evaluate).to eq 9
      expect(described_class.new("D8005AC2A8F0").evaluate).to eq 1
      expect(described_class.new("F600BC2D8F").evaluate).to eq 0
      expect(described_class.new("9C005AC2F8F0").evaluate).to eq 0
      expect(described_class.new("9C0141080250320F1802104A08").evaluate).to eq 1
    end
  end
end
