# frozen_string_literal: true

require 'json'
require 'jekyll-recipe/recipe'
require 'active_support/core_ext/string'

module Jekyll
  module Recipe
    ##
    # Produces a LD-JSON HTML tag ("structured data").
    class SeoTag < Liquid::Tag
      def render(context)
        @context = context

        "<script type=\"application/ld+json\">#{hash.to_json}</script>"
      end

      private

      def recipe
        @recipe ||= Jekyll::Recipe::Recipe.for_page(@context['page'])
      end

      # rubocop:disable Metrics/AbcSize
      def hash
        {
          "@context": 'https://schema.org',
          "@type": 'Recipe',
          name: recipe.title,
          datePublished: recipe.date_published.iso8601,
          recipeIngredient: recipe.ingredients,
          recipeInstructions: recipe.instructions,
          recipeYield: recipe.recipe_yield,
          cookingMethod: recipe.cooking_method,
          prepTime: recipe.prep_time.iso8601,
          cookTime: recipe.cook_time.iso8601,
          image: image_url,
          author: @context['page']['author'],
          description: @context['page']['description'],
          keywords: keywords
        }
      end
      # rubocop:enable Metrics/AbcSize

      def image_url
        return unless @context['page']['image']

        [@context['site']['url'], @context['site']['baseurl'], @context['page']['image']]
          .keep_if { |s| s.to_s != '' }
          .join('/')
      end

      def keywords
        return @context['page']['keywords'].join(',') if @context['page']['keywords']

        @context['page']['tags'].to_a.join(',')
      end
    end
  end
end
