class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :target_user, foreign_key: :target_user_id, class_name: :User

  def reverse_challenge
    Challenge.find_by(user_id: target_user_id, target_user_id: user_id)
  end
end
