require 'forwardable'
require 'uri'

module Ruboty
  module Rhymer
    class Store
      extend Forwardable

      def initialize(min: 10, max: 30)
        @data = []
        @min = min
        @max = max
      end

      attr_reader :min, :max
      def_delegators :@data, :[], :size, :clear, :shuffle, :join

      def concat_message(message)
        @data.push format_message(message)
        shrink
      end

      def sufficiently?
        @data.size >= @min
      end

      private

      def format_message(str)
        str
          .gsub(/\b[_\*~]+|[_\*~]+\b/, '') # remove decoration
          .gsub(URI.regexp, ' ') # remove URI
          .tr('!?', '！？') # replace exclamation
          .gsub(%r{[ -/:-@\[-\`\{-\~]+$}, ' ') # remove symbol
      end

      def shrink
        @data.shift until @data.size <= @max
      end
    end
  end
end
