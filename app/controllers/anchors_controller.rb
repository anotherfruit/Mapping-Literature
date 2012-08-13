class AnchorsController < ApplicationController

  hobo_model_controller

  auto_actions :new, :create, :index, :edit, :update

  def index
    if params[:type] == 'labelled'
      self.this = Anchor.labelled
    elsif params[:type] == 'unlabelled'
      self.this = Anchor.unlabelled
    else
      self.this = Anchor.all
    end

    hobo_index
  end

end
