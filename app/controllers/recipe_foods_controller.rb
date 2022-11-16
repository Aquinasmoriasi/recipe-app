class RecipeFoodsController < ApplicationController
  # before_action :set_recipe_food, only: %i[ show edit update destroy ]

  def index
    @recipe_foods = RecipeFood.all
  end

  def show
    @recipe_foods = RecipeFood.find(params[:id])
  end

  def create
    recipe_food = RecipeFood.create(recipe_params)
    recipe_food.recipe = Recipe.find(params[:recipe_id])
    recipe_food.food = Food.find(params[:food])

    if recipe_food.save
      flash[:success] = 'New Ingredient was successfully added.'
      redirect_to recipe_path(recipe_food.recipe)
    else
      flash[:danger] = 'New Ingredient adding Failed. Please try again.'
    end
  end

  def new
    @recipe_food = RecipeFood.new
    @foods = Food.all
  end

  def destroy
  end

  def edit
  end

  private

  def recipe_params
    params.require(:recipe_food).permit(:quantity)
  end
end
