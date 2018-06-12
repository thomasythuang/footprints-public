require 'spec_helper'

describe ChatMessagesController do
  let!(:current_user) do
    User.create!({
      email:    'a@a.com',
      password: 'password'
    })
  end

  let!(:other_user) do
    User.create!({
      email:    'b@b.com',
      password: 'pssaword'
    })
  end

  before do
    allow(subject).to receive(:current_user).and_return(current_user)
  end

  describe 'index' do
    context 'when fighter in params is not a match' do
      it 'redirects to root' do
        get :show, fighter_id: other_user.id

        expect(response).to redirect_to('/')
      end
    end

    context 'when fighter in params is a match' do
      before do
        Challenge.create!(user_id: current_user.id, target_user_id: other_user.id, challenged: true)
        Challenge.create!(user_id: other_user.id, target_user_id: current_user.id, challenged: true)
      end

      it 'assigns messages with that user to @messages' do
        message_1 = ChatMessage.create!(sender_id:    current_user.id,
                                        recipient_id: other_user.id,
                                        message:      'hello')
        message_2 = ChatMessage.create!(sender_id:    other_user.id,
                                        recipient_id: current_user.id,
                                        message:      'bonjour')

        get :show, fighter_id: other_user

        expect(assigns(:messages)).to eq([message_1, message_2])
      end

      it 'assigns fighter model to @fighter' do
        get :show, fighter_id: other_user.id

        expect(assigns(:fighter)).to eq(other_user)
      end
    end
  end

  describe 'create' do
    it 'creates a chat message with given params and redirects to chat page' do
      message = 'youre a noob'
      post :create, fighter_id: other_user.id, message: message

      expect(ChatMessage.first.attributes)
        .to include(
          'sender_id' => current_user.id,
          'recipient_id' => other_user.id,
          'message' => message
        )
    end

    context 'when params are not present' do
      it 'raises error' do
        expect { post :create, fighter_id: other_user.id }.to raise_error(ActiveRecord::StatementInvalid)
      end
    end
  end
end
