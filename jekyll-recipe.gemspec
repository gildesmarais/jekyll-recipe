# frozen_string_literal: true

require_relative 'lib/jekyll-recipe/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-recipe'
  spec.version       = Jekyll::Recipe::VERSION
  spec.authors       = ['Gil Desmarais']
  spec.email         = ['jekyll-recipe@desmarais.de']

  spec.summary       = 'Renders recipes on your Jekyll website.'
  spec.description   = 'Showing recipes on your website.'
  spec.homepage      = 'https://github.com/gildesmarais/jekyll-recipe'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gildesmarais/jekyll-recipe'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  spec.files = Dir['{lib}/**/*.*', '*.md']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'jekyll', '>= 3.0', '< 5.0'
  spec.add_development_dependency 'byebug'
end
