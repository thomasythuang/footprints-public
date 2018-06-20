class CreateMatches < ActiveRecord::Migration
  def up
    create_table :matches do |t|
      t.integer :fighter_1_id, null: false
      t.integer :fighter_2_id, null: false
      t.integer :winner_id
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE matches
        ADD CONSTRAINT fighter_1_id_fk
          FOREIGN KEY (fighter_1_id)
          REFERENCES users (id),
        ADD CONSTRAINT fighter_2_id_fk
          FOREIGN KEY (fighter_2_id)
          REFERENCES users (id),
        ADD CONSTRAINT winner_id_fk
          FOREIGN KEY (winner_id)
          REFERENCES users (id);
    SQL
  end

  def down
    drop_table :matches
  end
end
