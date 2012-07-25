class FrontController < ApplicationController

  hobo_controller

  def parse_sort_param(arg1, *args)
    _, desc, field = *params[:sort]._?.match(/^(-)?([a-z_]+(?:\.[a-z_]+)?)$/)

    if field
      if arg1.is_a?(Hash)
        db_sort_field = arg1[field] || arg1[field.to_sym]
      else
        db_sort_field = field if field.in?(args) || field.to_sym.in?(args) || field == arg1.to_s
      end

      if db_sort_field
        @sort_field = field
        @sort_direction = desc ? "desc" : "asc"

        "#{db_sort_field} #{@sort_direction}"
      end
    end
  end


  def index
    @fragments = Fragment.find(:all)
    @books = Creation.include(:authors)
    @books = @books.search([params[:search], "authors.first_name",
                            "authors.last_name", "creations.title"]) if params[:search]
    @books = @books.order(parse_sort_param({:title =>
                                                "creations.title", :authors => "authors.last_name", :published_at =>
        "creations.published_at", :fragments_count =>
        "creations.fragments _count"})) if params[:sort]
  end

  def summary
    if !current_user.administrator?
      redirect_to user_login_path
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

end
