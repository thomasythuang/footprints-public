require 'spec_helper'

describe MatchesController do
  describe '#show' do
    let!(:fighter_1) { User.create!({email: 'a@a.com', password: 'password' }) }
    let!(:fighter_2) { User.create!({email: 'b@b.com', password: 'pssaword' }) }

    let!(:match) { Match.create!(fighter_1_id: fighter_1.id, fighter_2_id: fighter_2.id, winner_id: fighter_1.id) }

    it 'assigns a match' do
      get :show, match_id: match.id

      expect(assigns(:match)).to eq(match)
    end

    it 'assigns fighter 1' do
      get :show, match_id: match.id

      expect(assigns(:fighter_1)).to eq(fighter_1)
    end

    it 'assigns fighter 2' do
      get :show, match_id: match.id

      expect(assigns(:fighter_2)).to eq(fighter_2)
    end

    it 'assigns winner' do
      get :show, match_id: match.id

      expect(assigns(:winner_id)).to eq(match.winner_id)
    end
  end


  describe '#index' do
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

    before do
      allow(subject).to receive(:current_user).and_return(current_user)
    end

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
