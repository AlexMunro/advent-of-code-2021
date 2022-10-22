# frozen_string_literal: true

require "bundler/setup"
require "debug"

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.example_status_persistence_file_path =
    "spec/examples.txt"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
