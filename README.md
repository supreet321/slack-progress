# Slack::Progress

## Demo

![Demo](https://i.imgur.com/3BFrK53.gif)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack-progress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack-progress

## Usage
Pre-requisites:
- A slack app for your workspace with `chat:write` permissions.
- Channel ID where messages should be posted (starts with 'C')
Then you can run the following 
```ruby
token = YOUR_BOT_TOKEN_HERE # Required
channel_id = YOUR_CHANNEL_ID_HERE # Required (Note: this is different from Channel name)
title = 'My Progress:' # Optional (Default is '')

p = SlackProgress.new(token, channel_id, {title: title})
thread_id = nil
count = 0

while count <= 50
  response = p.update_progress(thread_id: thread_id, current_value: count, max_value: 50)
  thread_id = response.thread_id
  count += 1
  sleep (1)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/supreet321/slack-progress.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
