# frozen_string_literal: true

require_relative "../../utils/input/lines"

class Day24
  extend Input::Lines

  INSTRUCTIONS = {
    inp: ->(vars, model_digits, a) { vars[a] = model_digits.shift },
    add: ->(vars, _, a, b) { vars[a] = vars[a] + get_value(b, vars) },
    mul: ->(vars, _, a, b) { vars[a] = vars[a] * get_value(b, vars) },
    div: ->(vars, _, a, b) { vars[a] = vars[a] / get_value(b, vars) unless get_value(b, vars).zero? },
    mod: ->(vars, _, a, b) { vars[a] = vars[a] % get_value(b, vars) unless vars[a].negative? || !get_value(b, vars).positive? },
    eql: ->(vars, _, a, b) { vars[a] = vars[a] == get_value(b, vars) ? 1 : 0 },
  }.freeze

  def self.part_one
    new(input).highest_valid_model
  end

  def self.part_two
  end

  def initialize(instruction_lines)
    @instructions = instruction_lines.map(&:split).map do |chunks|
      {
        operator: chunks[0].to_sym,
        operands: [chunks[1].to_sym],
      }.tap do |instr|
        if chunks[2]
          operand2 = chunks[2].match?(/\d+/) ? Integer(chunks[2]) : chunks[2].to_sym
          instr[:operands].push(operand2)
        end
      end
    end
  end

  def highest_valid_model
    model_number = 99_999_999_999_999
    loop {
      return model_number if valid_model(model_number)

      model_number -= 1
      while (problem_index = model_number.to_s.chars.find_index("0"))
        model_number -= 10**(14 - 1 - problem_index)
      end
    }
  end

  def valid_model(model_number)
    vars = { w: 0, x: 0, y: 0, z: 0 }
    model_digits = model_number.digits
    @instructions.all? do |instruction|
      INSTRUCTIONS[instruction[:operator]].call(vars, model_digits, *instruction[:operands])
    end && vars[:z].zero?
  end

  def self.get_value(argument, vars)
    (argument.is_a? Integer) ? argument : vars[argument] # rubocop:disable Style/TernaryParentheses
  end
end
