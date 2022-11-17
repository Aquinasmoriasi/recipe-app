class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @foods = current_user.foods
    recipe = Recipe.find(params[:recipe_id])
    return if recipe.user == current_user

    flash[:alert] =
      'You do not have access to add an ingredient on a recipe that does not belong to you.'
    redirect_to recipes_path
  end

  def create
    recipe_food = RecipeFood.create(recipe_food_params)
    recipe_food.recipe = Recipe.find(params[:recipe_id])
    recipe_food.food = Food.find(params[:food])

    if recipe_food.save
      flash[:success] = 'New Ingredient was successfully added.'
      redirect_to recipe_path(recipe_food.recipe)
    else
      flash[:danger] = 'New Ingredient adding Failed. Please try again.'
    end
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])

    unless recipe_food.recipe.user == current_user
      flash[:alert] =
        'You can not delete the ingredient that you did not added unless you are pro hacker'
      return redirect_to recipes_path
    end

    if recipe_food.destroy
      flash[:notice] = 'Ingredient was successfully deleted.'
    else
      flash[:alert] = 'Ingredient deleing failed. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
    recipe_food = RecipeFood.find(params[:id])
    unless recipe_food.recipe.user == current_user
      flash[:alert] =
        'You can not delete the ingredient that you did not added unless you are pro hacker'
      return redirect_to recipes_path
    end
    @recipe_food_edit = RecipeFood.find(params[:id])
    @foods = Food.all
  end

  def update
    @recipe_food_edit = RecipeFood.find(params[:id])
    if @recipe_food_edit.update(recipe_food_params)
      flash[:success] = 'Ingredient successfully updated.'
      redirect_to recipe_path(@recipe_food_edit.recipe)
    else
      flash[:danger] = 'Ingredient updating Failed. Please try again.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
