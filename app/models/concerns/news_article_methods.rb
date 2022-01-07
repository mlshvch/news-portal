# frozen_string_literal: true

module NewsArticleMethods
  def change_state(transit_to)
    case transit_to
    when 1
      approve
    when 2
      publish
    when 3
      archive
    end
    state
  end
end
