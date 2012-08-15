class AuthorsController < ApplicationController

  hobo_model_controller

  auto_actions :index, :new, :create, :edit, :update

end
