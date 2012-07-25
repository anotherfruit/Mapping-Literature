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
    if params[:date_start]
      @date_start = Date.parse(params[:date_start])
    else
      @date_start = Date.new(1800,1,1)
    end
    if params[:date_end]
      @date_end = Date.parse(params[:date_end])
    else
      @date_end = Date.today
    end
    Rails.logger.info @date_end
    @books = Creation.include(:authors)
    @books = @books.search([params[:search], "authors.first_name",
                            "authors.last_name", "creations.title"]) if params[:search]
    @books = @books.where("creations.published_at > ? AND creations.published_at < ?", @date_start, @date_end)
    @books = @books.order(parse_sort_param({:title =>
                                                "creations.title", :authors => "authors.last_name", :published_at =>
        "creations.published_at", :fragments_count =>
                                             "creations.fragments _count"})) if params[:sort]
    hobo_ajax_response if request.xhr?
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
