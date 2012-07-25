class GpscoordsetsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :index
  auto_actions_for :fragment, [:new, :create]
  index_action :timemap

  def timemap

    @fragments = Fragment.find(:all)



    @books = Creation.include(:authors)
    @books = @books.search([params[:search], "authors.first_name",
                            "authors.last_name", "creations.title"]) if params[:search]
    @books = @books.order(parse_sort_param({:title =>
                                                "creations.title", :authors => "authors.last_name", :published_at =>
        "creations.published_at", :fragments_count =>
        "creations.fragments _count"})) if params[:sort]

  end

end
