class AnchorsController < ApplicationController

  hobo_model_controller

  auto_actions :new, :create, :index, :edit, :update
  index_action :mobile

  def index
    # self.this is filtered by the map, @all_anchors isn't

    @all_anchors = Anchor.labelled
    self.this = Anchor.labelled

    @all_anchors = @all_anchors.search([params[:search], "name"]) if params[:search]
    self.this = self.this.search([params[:search], "name"]) if params[:search]

    unless params[:sw_lat].blank? || params[:sw_lon].blank? || params[:ne_lat].blank? || params[:ne_lon].blank?
      @sw_lat = params[:sw_lat]
      @sw_lon = params[:sw_lon]
      @ne_lat = params[:ne_lat]
      @ne_lon = params[:ne_lon]

      factory = Anchor.rgeo_factory_for_column(:shape)
      window = RGeo::Cartesian::BoundingBox.create_from_points(factory.point(@sw_lon, @sw_lat), factory.point(@ne_lon, @ne_lat))
      self.this = self.this.where{anchors.shape.op('&&', window)}.all
    end

    hobo_index
  end

  def mobile
    self.this = Anchor.includes(:fragments => :creation)
    hobo_index
  end

end
