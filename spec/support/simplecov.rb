require "simplecov"
require "simplecov_json_formatter"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
                                                                  SimpleCov::Formatter::HTMLFormatter,
                                                                  SimpleCov::Formatter::JSONFormatter,
                                                                ])
SimpleCov.minimum_coverage 70.0

SimpleCov.start do
  add_filter "app/channels/"
  add_filter "app/jobs/"
  add_filter "app/mailers/"
  add_filter "app/views/"

  add_filter "spec/"
  add_filter "config/"
  add_filter "db/"

  minimum_coverage 70
  minimum_coverage_by_file 50
end

