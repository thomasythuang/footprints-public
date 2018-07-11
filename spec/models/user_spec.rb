require 'spec_helper'

describe User do
  before :each do
    User.destroy_all
  end

  it "sets the attributes and saves if no existing email" do
    User.stub(:find_by_uid)
    User.create(email: 'test@user.com', password: 'Password123!')
    user = User.last
    user.email.should == 'test@user.com'
  end
end
