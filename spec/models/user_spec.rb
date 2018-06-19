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

  it "if user login doesn't match a craftsman email it doesn't assign user id" do
    User.create(email: 'test@user.com', password: 'Password123!')
    expect(User.last.craftsman_id).to be_nil
  end

  xit "if user login matches craftsman email it assigns user id" do
    Craftsman.create(:email => 'test@user.com', :employment_id => "test")
    User.create(email: 'test@user.com', password: 'Password123!')
    expect(User.last.craftsman_id).not_to be_nil
  end

  xit "assigns craftsman on method call" do
    Craftsman.create(:email => 'test@user.com', :employment_id => "test")
    user = User.new(:email => 'test@user.com')
    user.associate_craftsman
    expect(user.craftsman_id).not_to be_nil
  end
end
