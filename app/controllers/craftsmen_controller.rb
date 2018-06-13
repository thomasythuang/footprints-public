require './lib/repository'
require './lib/craftsmen/craftsmen_interactor'
require './lib/craftsmen/craftsmen_presenter'
require './lib/craftsmen/skills'

class CraftsmenController < ApplicationController
  def profile
    @user = current_user
    @avatar_url = current_user.avatar.url
  end

  def seeking
    craftsmen_presenter = CraftsmenPresenter.new(Footprints::Repository.craftsman)
    @craftsmen_seeking_residents = craftsmen_presenter.seeking_resident_apprentice
    @craftsmen_seeking_students  = craftsmen_presenter.seeking_student_apprentice
  end

  def update
    begin
      current_user.update!(user_params)

      redirect_to profile_path, notice: "Successfully saved profile"
    rescue Excon::Error
      redirect_to profile_path, flash: { error: ["There was a problem uploading your avatar"] }
    end
  end

  private

  def user_params
    params.require(:user).permit(:description, :avatar)
  end
end
