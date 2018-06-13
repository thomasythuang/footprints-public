class AddDopplerIdAndUidToCraftsmen < ActiveRecord::Migration
  def change
    add_column :craftsmen, :doppler_id, :integer
    add_column :craftsmen, :uid, :string
  end
end
