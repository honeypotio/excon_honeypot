# frozen_string_literal: true

require 'excon'
require 'json'

Excon.defaults[:expects] = [200, 201, 204]

module Excon
  def self.get_json(url, params = {}, &block)
    get(url, with_json(params), &block)
  end

  def self.post_json(url, params = {}, &block)
    post(url, with_json(params), &block)
  end

  def self.put_json(url, params = {}, &block)
    put(url, with_json(params), &block)
  end

  def self.with_json(params)
    params[:body] ||= JSON.dump(params[:json])
    params[:headers] ||= {}
    params[:headers]['Content-Type'] = 'application/json'
    params
  end
end

class Excon::Response
  def parsed_body(**params)
    JSON.parse(body, **params)
  end
end
