class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :target_user, foreign_key: :target_user_id
end
