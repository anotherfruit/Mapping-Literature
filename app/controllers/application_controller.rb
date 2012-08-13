class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter HoboRapid::PreviousUriFilter
end
