class FragmentsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  index_action :rss
  auto_actions_for :creation, [ :index, :new, :create ]

  def view

  end

end
