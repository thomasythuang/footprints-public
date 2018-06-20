class Match < ActiveRecord::Base
  self.table_name = 'matches'

  belongs_to :fighter_1, class_name: :User
  belongs_to :fighter_2, class_name: :User

  def opposing_fighter(fighter_id)
    return fighter_1 if fighter_id == fighter_2_id

    fighter_2
  end
end
