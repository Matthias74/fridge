json.pagination do
  json.current_page @recipes.current_page
  json.total_pages  @recipes.total_pages
end

json.recipes @recipes do |recipe|
  json.name recipe.name
  json.rate recipe.rate
  json.author_tip recipe.author_tip
  json.budget recipe.budget
  json.prep_time recipe.prep_time
  json.difficulty recipe.difficulty
  json.people_quantity recipe.people_quantity
  json.cook_time recipe.cook_time
  json.total_time recipe.total_time
  json.nb_comments recipe.nb_comments
  json.ingredients recipe.ingredients do |ingredient|
    json.name ingredient.name
    json.quantity ingredient.quantity
  end
end