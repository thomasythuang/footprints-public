shared_examples "user repository" do
  let(:repo) { described_class.new }
  let(:attrs) do
    {
      :login => "test@user.com",
      :email => "test@user.com",
      :password => "Password123!"
    }
  end
  let(:user) { repo.create(attrs) }

  let(:auth_hash) {{
    'provider' => 'google_oauth2',
    'uid' => '123456',
    'info' => {
      'email' => 'test@user.com'
    }}}

  before do
    repo.destroy_all
    user
  end

  it "creates" do
    user.should_not be_nil
  end

  it "has an id" do
    user.id.should_not be_nil
  end

  it "finds by login" do
    repo.find_by_login(user.login).should == user
  end

  it "finds by id" do
    repo.find_by_id(user.id).should == user
  end
end
