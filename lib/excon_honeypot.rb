# frozen_string_literal: true

require 'json'
require 'excon'
require_relative './excon/middleware/logger'

Excon.defaults[:expects] = [200, 201, 204]
Excon.defaults[:middlewares].push(Excon::Middleware::Logger)

module Excon
  def self.post(url, params = {}, &block)
    new(url, with_json(params)).request(method: :post, &block)
  end

  def self.put(url, params = {}, &block)
    new(url, with_json(params)).request(method: :put, &block)
  end

  def self.patch(url, params = {}, &block)
    new(url, with_json(params)).request(method: :patch, &block)
  end

  def self.with_json(params)
    json = params.delete(:json)
    return params if json.nil?

    params[:body] ||= JSON.dump(json)
    params[:headers] ||= {}
    params[:headers]['Content-Type'] = 'application/json'
    params
  end
end

module Excon
  class Response
    def parsed_body(**params)
      JSON.parse(body, **params)
    end
  end
end
