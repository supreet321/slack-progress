module SlackProgress
  class MessageBuilder

    def initialize(formatting_options)
      @formatting_options = formatting_options
    end

    def build_message(current_value, max_value)
      num_boxes = 10

      ratio = current_value.to_f / max_value.to_f
      percentage = (ratio * 100).round(1)

      fill_count = (percentage / num_boxes).round
      remaining_count = num_boxes - fill_count

      message = @formatting_options.title
      message += "\n"
      message += (@formatting_options.completed_filler) * fill_count
      message += (@formatting_options.remaining_filler) * remaining_count
      message += " #{current_value} / #{max_value}"
      message += " (#{percentage} %) finished."
      message
    end
  end
end