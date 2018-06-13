require 'spec_helper'

describe ChallengesController do
  let(:mock_current_user) { double(::User, id: 1) }

  before do
    allow(subject).to receive(:current_user).and_return(mock_current_user)

    request.env['HTTP_REFERER'] = '/'
  end

  describe 'create' do
    it 'creates a user with given params' do
      post :create, target_user: 2, challenged: true

      expect(Challenge.first.attributes)
        .to include(
          'user_id' =>        1,
          'target_user_id' => 2,
          'challenged' =>     true
        )
    end

    context 'when params are not present' do
      it 'raises error' do
        expect { post :create }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end
  end
end
