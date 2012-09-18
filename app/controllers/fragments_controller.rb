class FragmentsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:new, :create]
  index_action :rss
  auto_actions_for :creation, [ :index, :new, :create ]

  def create_for_creation
    hobo_create do
      if valid?
        if params["after_submit"] =~ /(fragment=)0($|&)/
          params["after_submit"].gsub!(/(fragment=)0($|&)/, "\\1#{this.id}\\2")
        end
      end
      create_response(:new_for_creation)
    end
  end
end
