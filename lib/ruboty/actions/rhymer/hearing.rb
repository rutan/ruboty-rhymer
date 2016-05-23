require 'rhymer'

module Ruboty
  module Actions
    module Rhymer
      class Hearing < ::Ruboty::Actions::Base
        def call(store)
          store.push message.original[:body]
          rhyme = try_rhymer(store.join('。'))
          return unless rhyme
          store.clear
          message.reply("#{rhyme[0]}　#{rhyme[1]}")
        end

        private

        def try_rhymer(message)
          ::Rhymer::Parser.new(message).rhymes.first
        end
      end
    end
  end
end
