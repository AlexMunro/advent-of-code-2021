# frozen_string_literal: true

module Input
  # Finds the appropriate input file for the given day's solution
  module File
    def self.extended(target)
      target.const_set(:INPUT, ::File.expand_path("../../inputs/#{target.name.downcase}.txt", ::File.dirname(__FILE__)))
    end
  end
end
