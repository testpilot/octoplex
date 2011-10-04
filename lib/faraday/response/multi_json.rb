require 'multi_json'
require 'yajl'

module Faraday
  class Response
    class MultiJson < Response::Middleware

      def initialize(*args)
        super
        ::MultiJson.engine = :yajl
      end

      def on_complete(env)
        begin
          env[:body] = ::MultiJson.decode(env[:body])
        rescue MultiJson::ParserError
          env[:body] = nil
        end
      end

    end
  end
end