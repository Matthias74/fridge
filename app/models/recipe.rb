class Recipe < ApplicationRecord
  self.per_page = 10

  has_and_belongs_to_many :ingredients

  scope :by_ingredients, ->(ingredients) do
    ingredients_name_query = ingredients.map do |ing|
      "`ingredients`.`name` LIKE ?"
    end.join(" OR ")

    joins(:ingredients)
      .where(ingredients_name_query, *ingredients.map { |ing| "#{ing}%" })
      .select("recipes.*, COUNT(ingredients.id) as number_of_matching_ingredients")
      .group("recipes.id")
      .order("number_of_matching_ingredients DESC")
  end
end