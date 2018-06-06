class MatchesController < ApplicationController

  def index
    @matched_fighters = matches_for_current_user
  end

  private

  def matches_for_current_user
    # this could probably be optimized
    Challenge.where(user_id: current_user.id, challenged: true)
      .select { |challenge| challenge.reverse_challenge.try(:challenged) }
      .map(&:target_user)
  end
end
