class CreationsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  autocomplete

  def create
    hobo_create do
      if valid?
        if params["after_submit"].include?("creations//fragment")
          params["after_submit"].gsub!("creations//fragments", "creations/#{this.id}/fragments")
        end
      end
      create_response(:new)
    end
  end
end
