require 'spec_helper'

describe MatchesController do
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

  before do
    allow(subject).to receive(:current_user).and_return(current_user)
  end

  describe '#show' do
    let!(:match) { Match.create!(fighter_1_id: current_user.id, fighter_2_id: matched_user.id, winner_id: current_user.id) }

    it 'assigns a match' do
      get :show, match_id: match.id

      expect(assigns(:match)).to eq(match)
    end

    it 'assigns fighter 1' do
      get :show, match_id: match.id

      expect(assigns(:fighter_1)).to eq(current_user)
    end

    it 'assigns fighter 2' do
      get :show, match_id: match.id

      expect(assigns(:fighter_2)).to eq(matched_user)
    end

    it 'assigns winner' do
      get :show, match_id: match.id

      expect(assigns(:winner_id)).to eq(match.winner_id)
    end

    context 'when the current user is not of the users in the match' do
      let!(:random_user) do
        User.create!({
          email:    'c@c.com',
          password: 'psswrd'
        })
      end

      before do
        allow(subject).to receive(:current_user).and_return(random_user)
      end

      it 'redirects to root' do
        get :show, match_id: match.id

        expect(response).to redirect_to root_path
      end
    end
  end


  describe '#index' do
    it 'assignes matches and fighters for the current user when current user is fighter 1' do
      match = Match.create!(fighter_1_id: current_user.id, fighter_2_id: matched_user.id)

      get :index

      expect(assigns(:matches)).to eq([{ match: match, fighter: matched_user }])
    end

    it 'assignes matches and fighters for the current user when current user is fighter 2' do
      match = Match.create!(fighter_1_id: matched_user.id, fighter_2_id: current_user.id, )

      get :index

      expect(assigns(:matches)).to eq([{ match: match, fighter: matched_user }])
    end
  end
end
