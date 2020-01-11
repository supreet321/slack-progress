module SlackProgress
  class OptionsParser

    def initialize(options = {})
      @options = options
    end

    def parse
      OpenStruct.new(
        app_options: app_options,
        formatting_options: formatting_options,
      )
    end

    private

    def app_options
      OpenStruct.new(
        # username: username,
        # icon_emoji: icon_emoji,
      )
    end

    def formatting_options
      OpenStruct.new(
        remaining_filler: remaining_filler,
        completed_filler: completed_filler,
        title: title,
      )
    end

    def remaining_filler
      @options[:remaining_filler] || ':white_medium_square:'
    end

    def completed_filler
      @options[:completed_filler] || ':black_medium_square:'
    end

    def title
      @options[:title] || ''
    end
  end
end