# bundle exec prometheus_exporter -a lib/graphql_collector.rb
# see https://github.com/discourse/prometheus_exporter/blob/e5ec9ac55d7321b245b9bca0028dc7de1d3f63d3/README.md#graphql-support
# and https://github.com/rmosolgo/graphql-ruby/blob/master/guides/queries/tracing.md#prometheus

if defined?(PrometheusExporter::Server)
  require "graphql/tracing"

  class GraphQLCollector < GraphQL::Tracing::PrometheusTracing::GraphQLCollector
  end
end

