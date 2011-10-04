require "octoplex/version"

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

    # @private
    def log
      @log ||= begin
        log = Logger.new($stdout)
        log.level = Logger::INFO
        log
      end
    end

  end
end
