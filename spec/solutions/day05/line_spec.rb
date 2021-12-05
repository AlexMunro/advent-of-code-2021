# frozen_string_literal: true

require "./solutions/day05/line"

RSpec.describe Line do
  describe ".from_string" do
    subject { described_class.from_string(line_string) }

    context "with a correctly formed string" do
      let(:line_string) { "leadingjunk--;1,2 -> 3,4;@endjunk;\n" }

      it "creates a #{described_class} object" do
        is_expected.to have_attributes(x1: 1, y1: 2, x2: 3, y2: 4)
      end
    end

    context "with a malformed string" do
      let(:line_string) { "This isn't a line!" }

      it "throws an error when the string is malformed" do
        expect { subject }.to raise_error(Line::LineFormatError)
      end
    end
  end

  describe "#enumerate_points" do
    subject { described_class.from_string(line_string).enumerate_points }

    context "for horizontal lines" do
      let(:line_string) { "1,2 -> 5,2" }

      it "contains points along the x axis" do
        is_expected.to contain_exactly [1, 2], [2, 2], [3, 2], [4, 2], [5, 2]
      end
    end

    context "for vertical lines" do
      let(:line_string) { "1,2 -> 1,6" }

      it "contains points along the y axis" do
        is_expected.to contain_exactly [1, 2], [1, 3], [1, 4], [1, 5], [1, 6]
      end
    end

    context "for upward sloping, 45 degree diagonal lines" do
      let(:line_string) { "1,1 -> 5,5" }

      it "contains points along the line" do
        is_expected.to contain_exactly [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]
      end
    end

    context "for downward sloping, 45 degree diagonal lines" do
      let(:line_string) { "1,5 -> 5,1" }

      it "contains points along the line" do
        is_expected.to contain_exactly [1, 5], [2, 4], [3, 3], [4, 2], [5, 1]
      end
    end
  end
end
