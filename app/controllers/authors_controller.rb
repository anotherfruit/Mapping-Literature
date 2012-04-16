class AuthorsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :creations, [:create, :new]

  def new_for_creation
    @book = Creation.find_by_id(params[:creation_id])
    hobo_new
  end


  def create
    @creation = Creation.find_by_id(params[:creation][:id])
    hobo_create do
      @this.creations=[@creation]
      redirect_to @creation if valid?
    end
  end
end
