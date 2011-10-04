module Octoplex
  class Client

    autoload :Root,       'octoplex/client/root'
    autoload :Base,       'octoplex/client/base'
    autoload :User,       'octoplex/client/user'
    autoload :Repository, 'octoplex/client/repository'

    include Octoplex::Client::Root

    attr_accessor :options

    def initialize(options = nil)
      @options = options
    end

    def connection
      @connection ||= Octoplex::Connection.new(options)
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
