class MatchesController < ApplicationController

  def index
    @matches = matches
  end

  def show
    @match = Match.find(params.require(:match_id))

    @fighter_1 = @match.fighter_1
    @fighter_2 = @match.fighter_2

    @winner_id = @match.winner_id
  end

  def update
    match = Match.find(params[:match_id])

    match.update(match_params)

    redirect_to show_match_path, notice: "Successfully updated match"
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
end
