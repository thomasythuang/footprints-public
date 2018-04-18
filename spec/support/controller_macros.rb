module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(email: 'test@example.com', password: 'Password123!')
      sign_in user
    end
  end
end
