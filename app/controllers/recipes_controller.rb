require 'pry'
class RecipesController < ApplicationController

	def new
		@recipe = Recipe.new
		@ingredients = Ingredient.all
	end

	def create
		@recipe = Recipe.create(recipe_params(:name))
		
		ingredient_ids = params[:recipe][:ingredients].reject(&:empty?)
		ingredients = ingredient_ids.map do |id|
			Ingredient.find(id.to_i)
		end
		
		@recipe.ingredients << ingredients

		redirect_to recipe_path(@recipe)
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def edit
		@recipe = Recipe.find(params[:id])
		@ingredients = Ingredient.all
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params(:name))
			ingredient_ids = params[:recipe][:ingredients].reject(&:empty?)
			ingredients = ingredient_ids.map do |id|
				Ingredient.find(id.to_i)
			end
			@recipe.update(ingredients: ingredients)
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	private
	def recipe_params(*args)
		params.require(:recipe).permit(*args)
	end
end
