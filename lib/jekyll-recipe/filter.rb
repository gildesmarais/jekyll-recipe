# frozen_string_literal: true

module Jekyll
  module Recipe
    ##
    #
    module Filter
      def recipe_pretty_duration(duration)
        rest, _secs = duration.to_i.divmod(60)
        rest, mins = rest.divmod(60)
        _days, hours = rest.divmod(24)

        [hours, mins].map { |i| format('%02d', i) }.join(':')
      end
    end
  end
end
