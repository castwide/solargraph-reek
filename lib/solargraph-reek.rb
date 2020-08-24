require 'solargraph'
require 'solargraph-reek/version'
require 'reek'

module Solargraph
  module Reek
    class Reporter < Solargraph::Diagnostics::Base
      def diagnose source, _api_map
        configuration = ::Reek::Configuration::AppConfiguration.from_default_path
        examiner = ::Reek::Examiner.new(source.code.dup, configuration: configuration)
        examiner.smells.map { |w| warning_to_diagnostic(w) }
      rescue ::Reek::Errors::SyntaxError
        []
      end

      private

      # @param warning [::Reek::SmellWarning]
      # @return [Hash]
      def warning_to_diagnostic(warning)
        {
          range: Solargraph::Range.from_to(warning.lines.first - 1, 0, warning.lines.last, 0).to_hash,
          severity: Diagnostics::Severities::WARNING,
          source: 'Reek',
          message: "[#{warning.smell_type}] #{warning.message}"
        }
      end
    end
  end
end

Solargraph::Diagnostics.register 'reek', Solargraph::Reek::Reporter
