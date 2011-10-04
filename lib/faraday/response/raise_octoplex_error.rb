require 'faraday'
require 'multi_json'

# @api private
module Faraday
  class Response::RaiseOctoplexError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
      when 400
        raise Octoplex::BadRequest, error_message(response)
      when 401
        raise Octoplex::Unauthorized, error_message(response)
      when 403
        raise Octoplex::Forbidden, error_message(response)
      when 404
        raise Octoplex::NotFound, error_message(response)
      when 406
        raise Octoplex::NotAcceptable, error_message(response)
      when 422
        raise Octoplex::UnprocessableEntity, error_message(response)
      when 500
        raise Octoplex::InternalServerError, error_message(response)
      when 501
        raise Octoplex::NotImplemented, error_message(response)
      when 502
        raise Octoplex::BadGateway, error_message(response)
      when 503
        raise Octoplex::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      message = if body = response[:body]
        body = ::MultiJson.decode(body) if body.is_a? String
        ": #{body[:error] || body[:message] || ''}"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end
end