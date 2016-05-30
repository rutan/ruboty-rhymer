module Ruboty
  module Handlers
    class Rhymer < Base
      env :RHYMER_SCORE, 'The border score of rhymer (default: 10)', optional: true
      env :RHYMER_STOCK_MIN, 'Minimum size of stocked messages (default: 10)', optional: true
      env :RHYMER_STOCK_MAX, 'Maximum size of stocked messages size (default: 30)', optional: true
      env :RHYMER_OVERRIDE_TO, 'override `to` parameter of Ruboty', optional: true

      on(/(?:.+)/,
         name: 'hearing',
         all: true,
         hidden: true)

      def hearing(message)
        ::Ruboty::Actions::Rhymer::Hearing.new(message).call(store)
      end

      private

      def store
        @store ||= Ruboty::Rhymer::Store.new(min: stock_min, max: stock_max)
      end

      def stock_min
        (ENV['RHYMER_STOCK_MIN'] || 10).to_i
      end

      def stock_max
        (ENV['RHYMER_STOCK_MAX'] || 30).to_i
      end
    end
  end
end
