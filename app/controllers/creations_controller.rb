class CreationsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :authors, [:create, :new]

  def new_for_author
    @author = Author.find_by_id(params[:author_id])
    hobo_new
  end


  def create
    @author = Author.find_by_id(params[:author][:id])
    hobo_create do
      @this.authors=[@author]
      redirect_to @author if valid?
    end
  end
end
