# frozen_string_literal: true

require 'jekyll'
require 'jekyll-recipe/version'
require 'jekyll-recipe/recipe'
require 'jekyll-recipe/seo_tag'
require 'jekyll-recipe/filter'

module Jekyll
  module Recipe
    class Error < StandardError; end
  end
end

Jekyll::Hooks.register :recipes, :pre_render do |_doc, payload|
  payload['page']['recipe'] = Jekyll::Recipe::Recipe.for_page(payload['page']).to_h
end

Liquid::Template.register_tag('recipe_seo', Jekyll::Recipe::SeoTag)

Liquid::Template.register_filter(Jekyll::Recipe::Filter)
