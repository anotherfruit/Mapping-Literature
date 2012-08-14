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
    @books = Creation.includes(:authors)
    @books = @books.search([params[:search], "authors.first_name",
                            "authors.last_name", "creations.title"]) if params[:search]

    # @all_books isn't filtered by date or location; is used for
    # markers
    @all_books = Creation.includes(:authors)
    @all_books = @all_books.search([params[:search], "authors.first_name",
                            "authors.last_name", "creations.title"]) if params[:search]


    unless params[:date_start].blank? || params[:date_end].blank?
      @date_start = Date.parse(params[:date_start])
      @date_end = Date.parse(params[:date_end])
      @books = @books.where("creations.first_published_at > ? AND creations.first_published_at < ?", @date_start, @date_end)
    else
      @date_start = Date.new(1800,1,1)
      @date_end = Date.today
    end

    unless params[:sw_lat].blank? || params[:sw_lon].blank? || params[:ne_lat].blank? || params[:ne_lon].blank?
      @sw_lat = params[:sw_lat]
      @sw_lon = params[:sw_lon]
      @ne_lat = params[:ne_lat]
      @ne_lon = params[:ne_lon]

      factory = Anchor.rgeo_factory_for_column(:shape)
      window = RGeo::Cartesian::BoundingBox.create_from_points(factory.point(@sw_lon, @sw_lat), factory.point(@ne_lon, @ne_lat))
      @books = @books.include(:fragments => :anchors).where{anchors.shape.op('&&', window)}.all
    end

    unless params[:search].blank?
      @books = @books.search([params[:search], "authors.first_name",
                              "authors.last_name", "creations.title"])
    end

    unless params[:sort].blank?
      @books = @books.order(parse_sort_param({:title => "creations.title",
                                               :authors => "authors.last_name",
                                               :first_published_at => "creations.first_published_at",
                                               :fragments_count => "creations.fragments_count"}))
    end

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
