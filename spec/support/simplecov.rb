require "simplecov"
require "simplecov_json_formatter"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
                                                                  SimpleCov::Formatter::HTMLFormatter,
                                                                  SimpleCov::Formatter::JSONFormatter,
                                                                ])
SimpleCov.minimum_coverage 70.0

SimpleCov.start "rails"

