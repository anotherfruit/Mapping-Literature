class ApplicationController < ActionController::Base
  has_mobile_fu false

  protect_from_forgery
  after_filter HoboRapid::PreviousUriFilter
  before_filter :set_map_provider

  def set_map_provider
    if ['googlev3', 'openlayers', 'microsoft7', 'ovi'].include?(params[:map_provider])
      session[:map_provider] = params[:map_provider]
    elsif session[:map_provider].nil?
      session[:map_provider] = 'openlayers'
    end
  end
end
