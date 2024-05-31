valid_recipe_datas = []

def ingredient_attributes(ingredient)
  pattern = /^((.*?)\s(de|d')|(\d\s)|1\/\d)/
  match = pattern.match(ingredient)
  name = match ? ingredient.gsub(pattern, "").squish : ingredient
  {
    name: name.downcase,
    quantity: match ? match[0].squish : nil
  }
end

def has_invalid_ingredients?(ingredients)
  varchar_max_length = 255
  ingredients.pluck(:name).detect { |n| n.length > varchar_max_length }
end

def recipe_attributes(recipe_data)
  {
    rate: recipe_data["rate"]&.to_i,
    author_tip: recipe_data["author_tip"],
    budget: recipe_data["budget"],
    prep_time: recipe_data["prep_time"],
    name: recipe_data["name"],
    difficulty: recipe_data["difficulty"],
    people_quantity: recipe_data["people_quantity"]&.to_i,
    cook_time: recipe_data["cook_time"],
    total_time: recipe_data["total_time"],
    nb_comments: recipe_data["nb_comments"],
  }
end

File.readlines("#{Rails.root}/db/data/recipes.json").each do |line|
  begin
    recipe_data = JSON.parse(line)

    recipe_data[:ingredients_attributes] = recipe_data["ingredients"].map do |ingredient|
      ingredient_attributes(ingredient)
    end

    next if has_invalid_ingredients?(recipe_data[:ingredients_attributes])

    valid_recipe_datas << recipe_data
  rescue JSON::ParserError
    next
  end
end

ingredients = valid_recipe_datas.pluck(:ingredients_attributes).flatten.uniq.map do |ingredient_data|
  Ingredient.new(ingredient_data)
end

recipes = valid_recipe_datas.map do |recipe_data|
  Recipe.new(recipe_attributes(recipe_data))
end

Recipe.import recipes
Ingredient.import ingredients

valid_recipe_datas.each do |recipe_data|
  recipe = Recipe.find_by(recipe_attributes(recipe_data))
  next unless recipe

  recipe_data[:ingredients_attributes].each do |ingredient_data|
    ingredient = Ingredient.find_by(ingredient_data)
    next unless ingredient

    recipe.ingredients << ingredient
  end
end