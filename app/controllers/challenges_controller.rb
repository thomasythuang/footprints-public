class ChallengesController < ApplicationController

  def create
    Challenge.create!(
      user_id:        current_user.id,
      target_user_id: params[:target_user],
      challenged:     params[:challenged]
    )

    redirect_to :back
  end
end
