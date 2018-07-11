class AddLiveChatSetting < ActiveRecord::Migration
  def up
    execute <<-SQL
      INSERT INTO settings (name, value) VALUES ('live_chat', false)
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM settings WHERE name = 'live_chat'
    SQL
  end
end
