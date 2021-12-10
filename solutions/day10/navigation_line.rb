# frozen_string_literal: true

class NavigationLine
  def initialize(line)
    @line = line
  end

  BRACKETS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">",
  }.freeze

  # Corruption score for closing brackets, completion score for opening brackets
  SCORING = {
    ")" => 3,
    "]" => 57,
    "}" => 1_197,
    ">" => 25_137,
    "(" => 1,
    "[" => 2,
    "{" => 3,
    "<" => 4,
  }.freeze

  def corruption_score
    stack = []

    @line.chars.each do |char|
      if BRACKETS.keys.include? char
        stack.push(char)
      elsif char == BRACKETS[stack.last]
        stack.pop
      else
        return SCORING[char]
      end
    end

    0
  end

  def completion_score
    stack = []

    @line.chars.each do |char|
      if BRACKETS.keys.include? char
        stack.push(char)
      elsif char == BRACKETS[stack.last]
        stack.pop
      else
        return 0
      end
    end

    completion_stack_score(stack)
  end

  private

  def completion_stack_score(stack)
    stack.reverse.inject(0) do |running_total, next_bracket|
      (running_total * 5) + SCORING[next_bracket]
    end
  end
end
