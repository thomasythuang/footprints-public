class MatchesController < ApplicationController

  def index
    @matches = matches
  end

  def show
    @match = Match.find(params.require(:match_id))
    redirect_if_current_user_not_involved(@match)

    @fighter_1 = @match.fighter_1
    @fighter_2 = @match.fighter_2

    @winner_id = @match.winner_id
    @winner_name = User.find_by_id(@winner_id).try(:name)
  end

  def update
    match = Match.find(params[:match_id])
    redirect_if_current_user_not_involved(match)

    if match.winner_id.blank?
      match.update(match_params)

      redirect_to show_match_path, notice: "Successfully updated match"
    else
      redirect_to show_match_path, alert: "Sorry! The match result has already been recorded and cannot be changed. Sucks to suck."
    end
  end

  private

  def match_params
    params
      .require(:match)
      .permit(:winner_id)
  end

  def matches
    Match
      .includes(:fighter_1, :fighter_2)
      .where('fighter_1_id = ? OR fighter_2_id = ?', current_user.id, current_user.id)
      .map { |match| { match: match, fighter: match.opposing_fighter(current_user.id) } }
  end

  def redirect_if_current_user_not_involved(current_match)
    unless [current_match.fighter_1.id, current_match.fighter_2.id].include?(current_user.id)
      redirect_to root_path
    end
  end
end
