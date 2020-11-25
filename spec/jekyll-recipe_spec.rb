# frozen_string_literal: true

RSpec.describe Jekyll::Recipe do
  it 'has a version number' do
    expect(Jekyll::Recipe::VERSION).not_to be nil
  end
end
