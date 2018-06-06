require './lib/repository'
require './lib/craftsmen/craftsmen_interactor'
require './lib/craftsmen/craftsmen_presenter'
require './lib/craftsmen/skills'

class CraftsmenController < ApplicationController
  def profile
    @user = current_user
  end

  def seeking
    craftsmen_presenter = CraftsmenPresenter.new(Footprints::Repository.craftsman)
    @craftsmen_seeking_residents = craftsmen_presenter.seeking_resident_apprentice
    @craftsmen_seeking_students  = craftsmen_presenter.seeking_student_apprentice
  end

  def update
    current_user.update!(user_params)

    redirect_to profile_path, :notice => "Successfully saved profile"
  end

  private

  def user_params
    params.require(:user).permit(:description)
  end
end
