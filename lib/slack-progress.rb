require 'slack-progress/version'
require 'slack-progress/client'
require 'slack-progress/error'

module SlackProgress
  def self.new(token, channel_id, options={})
    SlackProgress::Client.new(token, channel_id, options)
  end
end
