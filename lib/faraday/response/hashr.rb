require 'hashr'

module Faraday
  class Response
    class Hashr < Response::Middleware

      def on_complete(env)
        begin
          env[:body] = ::Hashr.new(env[:body])
        rescue
          env[:body] = nil
        end
      end

    end
  end
end