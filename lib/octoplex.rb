require "octoplex/version"
require "cgi"
require "hashr"
require "octoplex/errors"

module Octoplex
  autoload :Connection, 'octoplex/connection'
  autoload :Client,     'octoplex/client'

  class << self
    # A global instance of the Client class
    #
    # Options:
    #   :token - The OAuth token you have retrieved earlier.
    #
    def client(options = {})
      @client ||= Octoplex::Client.new(options)
    end

    def discard_client!
      @client = nil
    end

    # @private
    def log
      @log ||= begin
        log = Logger.new($stdout)
        log.level = Logger::INFO
        log
      end
    end

    # Delegate missing API calls to client, so we can do things like:
    # Octoplex.users('octocat')
    # Octoplex.user
    # Octoplex.repos('octocat')
    def method_missing(meth, *args, &blk)
      if client.respond_to?(meth)
        client.send(meth, *args, &blk)
      else
        super
      end
    end
  end
end
