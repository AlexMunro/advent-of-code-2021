# frozen_string_literal: true

require_relative "./file"

module Input
  # One integer per line
  module IntList
    def self.extended(target)
      target.extend(Input::File)
    end

    def input
      ::File.open(self::INPUT).readlines[0].strip.split(",").map(&:to_i)
    end
  end
end
