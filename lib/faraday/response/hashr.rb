require 'hashr'

module Faraday
  class Response
    class Hashr < Response::Middleware

      def on_complete(env)
        begin
          if env[:body].is_a?(Array)
            env[:body] = env[:body].map { |o| ::Hashr.new(o) }
          else
            env[:body] = ::Hashr.new(env[:body])
          end
        rescue
          env[:body] = env[:body]
        end
      end

    end
  end
end