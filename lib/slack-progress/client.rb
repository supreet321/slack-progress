require 'slack-progress/message_builder'
require 'slack-progress/options_parser'
require 'slack-progress/connection'

module SlackProgress
  class Client

    attr_reader :parsed_options

    def initialize(token, channel_id, options = {})
      raise ArgumentError, 'Token required' if token.nil?
      raise ArgumentError, 'Channel ID required' if channel_id.nil?

      @token = token
      @channel_id = channel_id
      @parsed_options   = OptionsParser.new(options).parse
    end

    def update_progress(thread_id: nil, current_value:, max_value:)
      message_builder = MessageBuilder.new(parsed_options.formatting_options)
      text = message_builder.build_message(current_value, max_value)

      connection = Connection.new(@token, @channel_id)
      connection.send_request(text, thread_id)
    end
  end
end
