class ChallengesController < ApplicationController

  def create
    challenge = Challenge.new(
      user_id:        current_user.id,
      target_user_id: params[:target_user],
      challenged:     params[:challenged]
    )
    challenge.save!

    create_match if challenge.reverse_challenge.present?

    redirect_to :back
  end

  def create_match
    Match.create!(fighter_1_id: current_user.id, fighter_2_id: params[:target_user])
  end
end
