class FightersController < ApplicationController

  def index
    already_viewed_users = Challenge.where(user_id: current_user.id)
                                    .pluck(:target_user_id)
                                    .uniq

    @fighter = User.where.not(id: already_viewed_users + [current_user.id]).sample
  end
end
