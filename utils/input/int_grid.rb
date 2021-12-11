# frozen_string_literal: true

require_relative "./file"

module Input
  # Comma separated ints on multiple linesq
  module IntGrid
    def self.extended(target)
      target.extend(Input::File)
    end

    def input
      ::File.open(self::INPUT).readlines.map do |line|
        line.strip.chars.map(&:to_i)
      end
    end
  end
end
