require 'warehouse/prefetch_craftsmen'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    prefetch_craftsmen

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  rescue ::NotACraftsmanError => e
    redirect_to oauth_signin_path, notice: e.message
  end

  def prefetch_craftsmen
    auth_hash = request.env["omniauth.auth"]

    Warehouse::PrefetchCraftsmen.new.execute(auth_hash[:extra][:id_token]) if Rails.application.config.prefetch_craftsmen
  end
end
