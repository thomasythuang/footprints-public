class ApplicationController < ActionController::Base
  attr_accessor :repo
  before_action :authenticate_user!

  def admin?
    is_thomas_or_andrew?
  end
  helper_method :admin?

  protected
  def repo
    Footprints::Repository
  end

  def authenticate
    if !current_user || current_user.uid == nil
      session[:return_to] = request.url
      redirect_request
    end
  end

  def employee?
    redirect_to(new_user_session_url, :notice => "You don't have permission to view this page.") if !current_user || current_user.email.nil? || !current_user.email.include?("abcinc.com")|| current_user.uid == nil
  end

  def require_admin
    if !current_user.admin
      flash[:error] = ["You are not authorized to view this page"]
      redirect_to(root_url)
    end
  end

  def redirect_request
    if is_ajax_request
      redirect_to new_user_session_url, :status => :unauthorized
    else
      redirect_to new_user_session_url, :notice => "Please sign in through Google."
    end
  end

  def is_ajax_request
    request.headers["X-Requested-With"] == "XMLHttpRequest"
  end

  # well named method
  def is_thomas_or_andrew?
    current_user.email == 'thomas.huang@yello.co' || current_user.email == 'andrew.kellams@yello.co'
  end
end
