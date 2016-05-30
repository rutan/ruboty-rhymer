require 'forwardable'

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
        @data.concat(split_message(message))
        shrink
      end

      def sufficiently?
        @data.size >= @min
      end

      private

      def split_message(str)
        str
          .gsub(/\b[_\*~]+|[_\*~]+\b/, '') # remove decoration
          .split(/[[:space:]。！？\.]+/) # replace split character
          .select { |n| n.size >= 4 }
      end

      def shrink
        @data.shift until @data.size <= @max
      end
    end
  end
end
