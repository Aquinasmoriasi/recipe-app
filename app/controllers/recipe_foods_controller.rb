class RecipeFoodsController < ApplicationController

  def index
    @recipe_foods = RecipeFood.all
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
    recipe_food = RecipeFood.find(params[:id])
    redirect_to recipe_path(recipe_food.recipe)
    recipe_food.destroy
    flash[:danger] = 'Ingredient was successfully removed.'
  end
 
  def edit
    @recipe_food_edit = RecipeFood.find(params[:id])
    @foods = Food.all
  end

  def update
    @recipe_food_edit = RecipeFood.find(params[:id])
    if @recipe_food_edit.update(recipe_params)
      flash[:success] = 'Ingredient successfully updated.'
      redirect_to recipe_path(@recipe_food_edit.recipe)
    else
      flash[:danger] = 'Ingredient updating Failed. Please try again.'
    end
  end

  private

  def recipe_params
    params.require(:recipe_food).permit(:quantity)
  end
end
