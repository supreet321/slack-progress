require 'faraday'
require 'json'

module SlackProgress
  class Connection

    NEW_MESSAGE_URL = 'https://slack.com/api/chat.postMessage'
    UPDATE_MESSAGE_URL = 'https://slack.com/api/chat.update'

    class Response < OpenStruct
      def initialize(status, thread_id, body)
        super(status: status, thread_id: thread_id, body: body)
      end
    end

    def initialize(token, channel_id)
      @token = token
      @channel_id = channel_id
    end

    def send_request(text, thread_id)
      return unless text

      url = thread_id.nil? ? NEW_MESSAGE_URL : UPDATE_MESSAGE_URL
      data = build_form_data(text, thread_id)

      raw_response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(data)
        req.options[:timeout] = 2
        req.options[:open_timeout] = 2
      end

      handle_errors(raw_response)
      parsed_response(raw_response)
    end

    private

    def build_form_data(text, thread_id)
      form_data = { token: @token, channel: @channel_id, text: text }
      form_data.merge!(ts: thread_id) if thread_id
      form_data.merge!(@app_options.to_h)
      form_data
    end

    def handle_errors(response)
      raise SlackProgress::ConnectionError, "Received #{response.status}" unless response.success?

      parsed_response = JSON.parse(response.body)
      if parsed_response['ok'] == false
        raise SlackProgress::InvalidRequestError, "Error: #{parsed_response['error']}"
      end
    end

    def parsed_response(response)
      body = response.body
      status = response.status
      thread_id = JSON.parse(body).fetch('ts', nil)

      Response.new(status, thread_id, body)
    end
  end
end
