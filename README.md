# Jekyll::Recipe

This plugin enables you to write recipes in the front matter.
They'll show up nicely on your page and it produces SEO-friendly "structured data" for search engines and recipe managers.

Its data structure originates from [Schema.org Recipe](https://schema.org/Recipe), but you don't need to deal with the nitty-gritty details.

## TODOs

- [ ] add a Jekyll Generator
- [ ] support 'nutrition' [NutritionInformation](https://schema.org/NutritionInformation)
  - [ ] fix jsonld / google warnings: Missing field 'recipeCuisine' (optional)
- [ ] fix jsonld / google warnings: Missing field 'video' (optional)
- [ ] fix jsonld / google warnings: Invalid integer in property 'recipeYield' (optional)

## Installation

Add this line to your Jekyll website's Gemfile:

```ruby
gem 'jekyll-recipe', git: 'https://github.com/gildesmarais/jekyll-recipe', branch: 'main'
```

And list `jekyll-recipe` in your `_config.yml` under `plugins:`

```yaml
plugins:
  - jekyll-recipe
```

And then execute:

    $ bundle install

## Usage

### Create a collection for `recipes`

This approach is sensible when you have a dedicated recipe section on your website.

1. Create a folder called `_recipes`
2. create `_layout/recipe.html`
   (see below for a example)
3. add collection config to `_config.yml`
   ```yaml
   collections:
     recipes:
       output: true
   ```
4. configure a default layout for the collection in `_config.yml`
   ```yaml
   defaults:
     - scope:
         path: ""
         type: "recipes"
       values:
         layout: "recipe"
   ```

```html
---
layout: default
---

{% assign recipe = page.recipe %}

<main class="page">
  <article class="recipe">
    <h1>{{ recipe.title }}</h1>
    <p>{{ recipe.description }}</p>

    {% if recipe.image %}<img
      src="{{ recipe.image | absolute_url }}"
      role="presentation"
    />{% endif %}

    <table>
      <tbody>
        <tr>
          <th>Yield</th>
          <td>{{ recipe.recipe_yield }}</td>
        </tr>
        <tr>
          <th>Method</th>
          <td>{{ recipe.cooking_method }}</td>
        </tr>
        <tr>
          <th>Preparation time</th>
          <td>{{ recipe.prep_time | recipe_pretty_duration }}</td>
        </tr>
        <tr>
          <th>Cook time</th>
          <td>{{ recipe.cook_time | recipe_pretty_duration }}</td>
        </tr>
      </tbody>
    </table>

    <h2>Ingredients</h2>
    <ul>
      {% for ingredient in recipe.ingredients %}
      <li>
        <label>
          <input type="checkbox" />
          {{ ingredient }}
        </label>
      </li>
      {% endfor %}
    </ul>

    <h2>Instructions</h2>
    <ol>
      {% for instruction in recipe.instructions %}
      <li>
        <label>
          <input type="checkbox" />
          {{ instruction }}
        </label>
      </li>
      {% endfor %}
    </ol>

    <aside role="contentinfo">
      {{ recipe.author }} {{ recipe.date | date_to_long_string }}
    </aside>

    <button onclick="print()">Print</button>
  </article>
</main>

{% recipe_seo %}
```

### Add a recipe

Create a file in `_recipes`, e.g. _recipes/cake.md_

Add the recipe in the front matter:

```yaml
---
name: Mom's World Famous Banana Bread
description: |
  This classic banana bread recipe comes from my mom -- the walnuts add a nice texture and flavor to the banana bread.
image: bananabread.jpg
date: "2020-11-24"
ingredients:
  - 3 or 4 ripe bananas, smashed
  - 1 egg
  - 3/4 cup of sugar
instructions:
  - Preheat the oven to 350 degrees.
  - Mix in the ingredients in a bowl.
  - Add the flour last.
  - Pour the mixture into a loaf pan and bake for one hour.
recipe_yield: 1 loaf
cooking_method: bake
prep_time: 15m
cook_time: 1h 15m
---

```

That's it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gildesmarais/jekyll-recipe.
