class CreateChallengesTable < ActiveRecord::Migration
  def up
    create_table :challenges do |t|
      t.references :user,        null: false
      t.references :target_user, null: false
      t.boolean    :challenged,  null: false
    end

    execute <<-SQL
      ALTER TABLE challenges
        ADD CONSTRAINT user_id_fk
          FOREIGN KEY (user_id)
          REFERENCES users (id),
        ADD CONSTRAINT target_user_id_fk
          FOREIGN KEY (target_user_id)
          REFERENCES users (id);
    SQL
  end

  def down
    drop_table :challenges
  end
end
