require 'rhymer'

module Ruboty
  module Actions
    module Rhymer
      class Hearing < ::Ruboty::Actions::Base
        def call(store)
          store.concat_message(message.original[:body])
          return unless store.sufficiently?

          rhyme = try_rhymer(store)
          return unless rhyme
          post_rhyme(rhyme)
          store.clear
        end

        private

        def generate_reply(rhyme)
          buf = []
          buf.push 'Yo!'
          buf.push rhyme[0]
          buf.push rhyme[1]
          buf.join('　')
        end

        def try_rhymer(messages)
          ::Rhymer::Parser.new(messages.shuffle.join("。\n")).rhymes.reject do |rhyme|
            rhyme[0].include?(rhyme[1]) || rhyme[1].include?(rhyme[0])
          end.select do |rhyme|
            rhyme.last >= score_border
          end.sample
        end

        def post_rhyme(rhyme)
          options = {}
          unless ENV['RHYMER_OVERRIDE_TO'].to_s.empty?
            options[:to] = ENV['RHYMER_OVERRIDE_TO']
          end
          message.reply(generate_reply(rhyme), options)
        end

        def score_border
          (ENV['RHYMER_SCORE'] || 10).to_i
        end
      end
    end
  end
end
