require "faraday"
require "faraday/response/multi_json"

module Octoplex
  class Connection

    attr_reader :conn, :token, :rate_limit, :rate_limit_remaining

    def initialize(token = nil)
      @token = token
      setup
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
        req.params['access_token'] = self.token if self.token.is_a?(String)
      end

      if response.env[:response_headers].has_key?('x-ratelimit-limit')
        @rate_limit           = response.env[:response_headers]['x-ratelimit-limit'].to_i
        @rate_limit_remaining = response.env[:response_headers]['x-ratelimit-remaining'].to_i
      end

      response.body
    end

  end

end
