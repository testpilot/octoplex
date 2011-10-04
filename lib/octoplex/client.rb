module Octoplex
  class Client

    attr_accessor :token

    def initialize(options = nil)
      options ||= {}

      options = {
        :token => nil
      }.update(options)

      @token = options.delete(:token)
    end

    def connection
      @connection ||= Octoplex::Connection.new(token)
    end

    # The maximum number of API requests you can do this hour
    # for this token.
    def rate_limit
      connection.rate_limit
    end

    # The number of API requests you have left this hour.
    def rate_limit_remaining
      connection.rate_limit_remaining
    end

  end
end
