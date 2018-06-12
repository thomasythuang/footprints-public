require 'spec_helper'

describe MatchesController do

  describe 'index' do
    # this could obviously use factories, but they don't exist right now
    let!(:current_user) do
      User.create!({
        email:    'a@a.com',
        password: 'password'
      })
    end

    let!(:matched_user) do
      User.create!({
        email:    'b@b.com',
        password: 'pssaword'
      })
    end

    let!(:random_user) do
      User.create!({
        email:    'c@c.com',
        password: 'psswrd'
      })
    end

    before do
      allow(subject).to receive(:current_user).and_return(current_user)
    end

    it 'assigns users that have matched the current users to @matched_fighters' do
      Challenge.create!(user_id: current_user.id, target_user_id: matched_user.id, challenged: true)
      Challenge.create!(user_id: matched_user.id, target_user_id: current_user.id, challenged: true)
      Challenge.create!(user_id: current_user.id, target_user_id: random_user.id, challenged: true)

      get :index

      expect(assigns(:matched_fighters)).to eq([matched_user])
    end
  end
end
