module Octoplex
  class Client

    include Octoplex::API::Root

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

    # API Helper methods

    def get(path)
      connection.get(path)
    end

    def post(path, body)
      connection.post(path, body)
    end

    def put(path, body)
      connection.put(path, body)
    end

    def delete(path)
      connection.delete(path)
    end

  end
end
