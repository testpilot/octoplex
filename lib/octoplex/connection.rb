require "faraday"
require "faraday/response/multi_json"

module Octoplex
  class Connection
    def initialize
      setup
    end

    attr_reader :conn

    def token
      Octoplex.token
    end

    def setup
      @conn = Faraday.new(:url => 'https://api.github.com') do |builder|
        builder.use Faraday::Request::JSON
        builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
        builder.use Faraday::Response::MultiJson
      end
    end

    def authentication_param
      {:access_token => token}
    end

    def get(path)
      request(path, :get)
    end

    def post(path, body)
      request(path, :post, body)
    end

    def put(path, body)
      request(path, :put, body)
    end

    def delete(path)
      request(path, :delete)
    end

    private

    def request(path, method = :get, body = nil)
      response = conn.send(method) do |req|
        req.url(path)
        req.body = body unless body.nil?
        req.params['access_token'] = token if token.is_a?(String)
      end
      response.body
    end

  end

end
