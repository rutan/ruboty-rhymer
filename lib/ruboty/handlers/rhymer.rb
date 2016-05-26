module Ruboty
  module Handlers
    class Rhymer < Base
      env :RHYMER_SCORE, 'Rhymer score border', optional: true
      env :RHYMER_OVERRIDE_TO, 'override `to` parameter', optional: true

      on(/(?:.+)/,
         name: 'hearing',
         all: true,
         hidden: true)

      def hearing(message)
        ::Ruboty::Actions::Rhymer::Hearing.new(message).call(store)
      end

      private

      def store
        @store ||= []
      end
    end
  end
end
