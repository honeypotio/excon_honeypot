# frozen_string_literal: true

require 'excon'
require 'json'

Excon.defaults[:expects] = [200, 201, 204]

module Excon
  def self.post(url, params = {}, &block)
    super(url, with_json(params), &block)
  end

  def self.put(url, params = {}, &block)
    super(url, with_json(params), &block)
  end

  def self.with_json(params)
    return params if params[:json].nil?

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
