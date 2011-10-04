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

  end
end