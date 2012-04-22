class FragmentsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  index_action :rss

end
