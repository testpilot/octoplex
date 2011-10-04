require "octoplex/version"

module Octoplex
  autoload :Connection, 'octoplex/connection'

  class << self
    attr_accessor :token

    # @private
    def log
      @log ||= begin
        log = Logger.new($stdout)
        log.level = Logger::INFO
        log
      end
    end

    def connection
      @connection ||= Octoplex::Connection.new
    end
  end

end
