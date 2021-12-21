# frozen_string_literal: true

require_relative "./file"

module Input
  # Evaluate each line. Be extremely careful with your input!
  module EvalLines
    def self.extended(target)
      target.extend(Input::File)
    end

    def input
      ::File.open(self::INPUT).readlines.map(&:strip).map { |line| eval(line) } # rubocop:disable Security/Eval
    end
  end
end
