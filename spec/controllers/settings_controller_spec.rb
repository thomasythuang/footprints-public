require 'spec_helper'

describe SettingsController do
  let!(:live_chat_setting) { Setting.create!(name: 'live_chat', value: false) }
  let(:current_user) do
    User.create!({
      email:    'thomas.huang@yello.co',
      password: 'password'
    })
  end

  before do
    allow(subject).to receive(:current_user).and_return(current_user)
  end

  describe '#index' do
    it 'assigns live chat setting to instance var' do
      get :index

      expect(assigns(:live_chat_setting)).to eq(live_chat_setting)
    end

    context 'when the current user is not an admin' do
      let(:evil_user) do
        User.create!({
          email:    'bill@nye.com',
          password: 'password'
        })
      end

      before do
        allow(subject).to receive(:current_user).and_return(evil_user)
      end

      it 'redirects from the settings page' do
        get :index

        expect(response).to redirect_to (root_path)
      end
    end
  end

  describe '#update' do
    it 'updates given setting and sets flash message' do
      put :update, name: 'live_chat', setting: { value: true }

      expect(Setting.find_by_name('live_chat').value).to be true
      expect(flash[:notice]).to include('Setting updated successfully!')
    end

    it 'redirects non-permitted users' do

    end

    context 'when the update fails for some reason' do
      before do
        allow_any_instance_of(Setting).to receive(:update).and_return(false)
      end

      it 'sets flash error message' do
        put :update, name: 'live_chat', setting: { cheese: true }

        expect(flash[:error]).to include('Update failed. Sucks to suck.')
      end
    end
  end
end
