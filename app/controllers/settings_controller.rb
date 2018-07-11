class SettingsController < ApplicationController

  before_action :redirect_if_not_admin_user

  def index
    @live_chat_setting = Setting.find_by_name('live_chat')
  end

  def update
    successful = Setting.find_by_name(params[:name]).update(value: new_value)

    if successful
      flash[:notice] = 'Setting updated successfully!'
    else
      flash[:error] = 'Update failed. Sucks to suck.'
    end

    redirect_to update_settings_path
  end

  private

  def new_value
    params[:setting][:value]
  end

  def redirect_if_not_admin_user
    redirect_to root_path unless admin?
  end
end
