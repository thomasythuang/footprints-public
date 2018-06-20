require 'spec_helper'

describe ChallengesController do
  let!(:current_user) do
    User.create!({
      email:    'a@a.com',
      password: 'password'
    })
  end

  let!(:challenged_user) do
    User.create!({
      email:    'b@b.com',
      password: 'pssaword'
    })
  end

  before do
    allow(subject).to receive(:current_user).and_return(current_user)

    request.env['HTTP_REFERER'] = '/'
  end

  describe 'create' do
    it 'creates a user with given params' do
      post :create, target_user: challenged_user.id, challenged: true

      expect(Challenge.first.attributes)
        .to include(
          'user_id' =>        current_user.id,
          'target_user_id' => challenged_user.id,
          'challenged' =>     true
        )
    end

    context 'when params are not present' do
      it 'raises error' do
        expect { post :create }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end

    context 'when there is a reverse challenge present' do
      let!(:reverse_challenge) do
        Challenge.create!(user_id: challenged_user.id, target_user_id: current_user.id, challenged: true)
      end

      it 'creates a match' do
        post :create, target_user: challenged_user.id, challenged: true

        expect(Match.first.attributes)
          .to include(
            'fighter_1_id' => current_user.id,
            'fighter_2_id' => challenged_user.id
          )
      end
    end
  end
end
