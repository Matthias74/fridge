class Api::RecipesController < ApplicationController
  def index
    recipes
  end

  private

  def recipes
    @recipes = if params[:ingredients].present?
      Recipe.by_ingredients(params[:ingredients]).paginate(params[:page]|| 1)
    else
      Recipe.includes(:ingredients).paginate(params[:page]|| 1)
    end
  end
end