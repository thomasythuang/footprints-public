class CreateChatMessages < ActiveRecord::Migration
  def up
    create_table :chat_messages do |t|
      t.references :sender,    null: false
      t.references :recipient, null: false
      t.string     :message,   null: false
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE chat_messages
        ADD CONSTRAINT sender_id_fk
          FOREIGN KEY (sender_id)
          REFERENCES users (id),
        ADD CONSTRAINT recipient_id_fk
          FOREIGN KEY (recipient_id)
          REFERENCES users (id);
    SQL
  end

  def down
    drop_table :chat_messages
  end
end
