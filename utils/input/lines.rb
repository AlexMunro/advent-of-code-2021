# frozen_string_literal: true

require_relative "./file"

module Input
  # Input lines with newlines stripped
  module Lines
    def self.extended(target)
      target.extend(Input::File)
    end

    def input
      ::File.open(self::INPUT).readlines.map(&:strip)
    end
  end
end
