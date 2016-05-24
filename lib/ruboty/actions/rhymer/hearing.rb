require 'rhymer'

module Ruboty
  module Actions
    module Rhymer
      class Hearing < ::Ruboty::Actions::Base
        def call(store)
          store.concat split_message(message.original[:body])
          rhyme = try_rhymer(store)
          return unless rhyme
          store.clear
          message.reply(generate_reply(rhyme))
        end

        private

        def split_message(str)
          str
            .split(/[[:space:]。！？\.]+/)
            .select { |n| n.size >= 4 }
        end

        def generate_reply(rhyme)
          buf = []
          buf.push 'Yo!'
          buf.push rhyme[0]
          buf.push rhyme[1]
          buf.join('　')
        end

        def try_rhymer(messages)
          ::Rhymer::Parser.new(messages.join("。\n")).rhymes.select do |rhyme|
            rhyme.last >= score_border
          end.sample
        end

        def score_border
          (ENV['RHYMER_SCORE'] || 10).to_i
        end
      end
    end
  end
end
