require "faraday"
require "faraday/response/multi_json"
require "faraday/response/hashr"
require "faraday/response/raise_octoplex_error"

module Octoplex
  class Connection

    attr_reader :conn, :options, :conn_options, :token, :rate_limit, :rate_limit_remaining

    def initialize(options = {})
      options ||= {}

      @options = {
        :per_page => 100,
        :enable_caching => true,
        :logging => false,
        :token => nil
      }.update(options)

      @conn_options = {
        :logging => @options.delete(:logging),
        :access_token => @options.delete(:token),
        :enable_caching => @options.delete(:enable_caching)
      }

      @token = @conn_options[:access_token]
      @rate_limit = @rate_limit_remaining = 0
      setup
    end

    def setup
      @conn = Faraday.new(:url => 'https://api.github.com') do |builder|
        builder.use Faraday::Request::JSON
        builder.use Faraday::Response::Logger if conn_options[:logging].eql?(true)
        builder.use Faraday::Adapter::NetHttp
        builder.use Faraday::Response::Hashr
        builder.use Faraday::Response::RaiseOctoplexError
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

    def cache(path, response)
      if options[:enable_caching] == true
        (@cache ||= {})[path.to_s] = response
      end
      response
    end

    def cached(path)
      (@cache ||= {})[path.to_s]
    end

    def is_cached?(path)
      (@cache ||= {}).has_key?(path)
    end

    def clear_cache
      @cache = {}
    end

    def cache_size
      (@cache ||= {}).keys.size
    end

    private

    def request(path, method = :get, body = nil)
      if is_cached?(path)
        return cached(path)
      end

      data = make_request(path, method, body)
      cache(path, data)
    end

    def make_request(path, method = :get, body = nil)
      response = conn.send(method) do |req|
        req.url(path)
        req.body = body unless body.nil?
        req.params.merge!(authentication_param) if self.token.is_a?(String)
        req.params['per_page'] = self.options[:per_page] if (self.options.has_key?(:per_page) && method == :get)
      end

      if response.env[:response_headers].has_key?('x-ratelimit-limit')
        @rate_limit           = response.env[:response_headers]['x-ratelimit-limit'].to_i
        @rate_limit_remaining = response.env[:response_headers]['x-ratelimit-remaining'].to_i
      end

      response.body
    end

  end
end
