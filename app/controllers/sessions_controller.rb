require 'warehouse/prefetch_craftsmen'

class SessionsController < ApplicationController
  layout "sessions_layout"
  skip_before_action :authenticate_user!

  def ouath_sigin
  end
end
