# frozen_string_literal: true

module Excon
  module Middleware
    class Logger < Base
      @@sensitive_data = []

      def self.mask_sensitive_data(value)
        Array(value).each do |val|
          @@sensitive_data << val
        end
      end

      def request_call(datum)
        datum[:start_time] = Time.zone.now
        datum[:headers]['x-request-id'] ||= SecureRandom.uuid
        @stack.request_call(datum)
      end

      def response_call(datum)
        log_request(datum)
        @stack.response_call(datum)
      end

      def error_call(datum)
        log_request(datum)
        @stack.error_call(datum)
      end

      private

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def log_request(datum)
        method = datum[:method].to_s.upcase
        url = build_url(datum)
        body = datum[:connection].data[:body]&.squish
        request_id = datum[:headers]['x-request-id']
        response = datum[:response] || {}
        status = response[:status]
        response_body = response[:body]&.squish
        start_time = datum[:start_time]
        duration = start_time ? ((Time.zone.now - start_time) * 1000).round(0) : nil
        message = "Excon: Request with ID: #{request_id} #{method} #{url}"
        message += " with body: \"#{body}\"" if body
        message += " returned #{status}" if status
        message += " and took #{duration}ms" if duration

        @@sensitive_data.each do |sensitive_data|
          next unless sensitive_data.present?
          
          message&.gsub!(sensitive_data, '<filtered>')
          response_body&.gsub!(sensitive_data, '<filtered>')
        end

        Rails.logger.info(message)
        Rails.logger.info("Excon: Response payload \"#{response_body}\"")
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

      def build_url(datum)
        scheme = datum[:scheme]
        host = datum[:host]
        path = datum[:path]
        port = datum[:port]
        query = datum[:query]

        url = "#{scheme}://#{host}"
        url += ":#{port}" unless [80, 443].include?(port)
        url += path
        url += "?#{query}" if query
        url
      end
    end
  end
end
