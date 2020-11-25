# frozen_string_literal: true

require 'active_support/duration'

module Jekyll
  module Recipe
    ##
    #
    class Recipe
      KEYS = %w[title description image date author ingredients instructions
                recipe_yield cooking_method prep_time cook_time].freeze
      private_constant :KEYS

      attr_accessor(*KEYS)

      def initialize(title:, description:, image:, date:, author:, ingredients:, instructions:,
                     recipe_yield:, cooking_method:, prep_time:, cook_time:)
        KEYS.each { |key| instance_variable_set("@#{key}", binding.local_variable_get(key)) }
      end

      alias name title
      alias date_published date
      alias recipe_ingredient ingredients
      alias recipe_instructions instructions

      def to_h
        KEYS.map { |key| [key, public_send(key)] }.to_h
      end

      def self.for_page(page)
        attributes = page.to_h.slice(*KEYS).symbolize_keys

        attributes[:prep_time] = duration_from_string attributes[:prep_time]
        attributes[:cook_time] = duration_from_string attributes[:cook_time]

        new(**attributes)
      end

      UNIT_TO_METHOD = {
        y: ActiveSupport::Duration.method(:years),
        M: ActiveSupport::Duration.method(:months),
        w: ActiveSupport::Duration.method(:weeks),
        d: ActiveSupport::Duration.method(:days),
        h: ActiveSupport::Duration.method(:hours),
        m: ActiveSupport::Duration.method(:minutes),
        s: ActiveSupport::Duration.method(:seconds)
      }.freeze

      def self.duration_from_string(string)
        raise 'Duration Q is unsupported' if string.include?('Q')
        raise 'Duration ms is unsupported' if string.include?('ms')

        groups = "#{string.strip} ".scan(/(\d+(?:y{1}|Q{1}|M{1}|w{1}|h{1}|d{1}|h{1}|m{1}|s{1}|ms{1})\s)(?!\s)/)
        groups.flatten!

        groups.map! do |g|
          count, unit = g.strip.scan(/(\d*)(\w)/).flatten
          UNIT_TO_METHOD[unit.to_sym].call(count.to_i)
        end

        groups.reduce(0, :+)
      end
    end
  end
end
