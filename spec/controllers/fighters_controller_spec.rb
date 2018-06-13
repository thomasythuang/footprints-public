require 'spec_helper'

describe FightersController do

  describe 'index' do
    # this could obviously use factories, but they don't exist right now
    let!(:current_user) do
      User.create!({
        email:    'a@a.com',
        password: 'password'
      })
    end

    let!(:other_user_1) do
      User.create!({
        email:    'b@b.com',
        password: 'pssaword'
      })
    end

    let!(:other_user_2) do
      User.create!({
        email:    'c@c.com',
        password: 'psswrd'
      })
    end

    let!(:other_user_3) do
      User.create!({
        email:    'd@d.com',
        password: 'l337pa55w0rd'
      })
    end

    before do
      allow(subject).to receive(:current_user).and_return(current_user)
    end

    3.times do
      it 'randomly assigns a non-viewed fighter to @fighter' do
        Challenge.create!(user_id: current_user.id, target_user_id: other_user_1.id, challenged: true)
        Challenge.create!(user_id: other_user_2.id, target_user_id: other_user_3.id, challenged: true)

        get :index

        # in rspec 3 we could do expect(assigns(:fighter)).to eq(other_user_2).or eq(other_user_3)
        expect([other_user_2, other_user_3]).to include(assigns(:fighter))
      end
    end

    context 'when all other fighters have been viewed already' do
      it 'assigns nil to @fighter' do
        Challenge.create!(user_id: current_user.id, target_user_id: other_user_1.id, challenged: true)
        Challenge.create!(user_id: current_user.id, target_user_id: other_user_2.id, challenged: false)
        Challenge.create!(user_id: current_user.id, target_user_id: other_user_3.id, challenged: true)

        get :index

        expect(assigns(:fighter)).to be nil
      end
    end
  end
end
