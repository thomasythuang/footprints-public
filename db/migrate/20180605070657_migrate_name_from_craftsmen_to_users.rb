class MigrateNameFromCraftsmenToUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE users SET name = craftsmen.name
      FROM craftsmen
      WHERE craftsman_id = craftsmen.employment_id;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE users SET name = NULL
      FROM craftsmen
      WHERE craftsman_id = craftsmen.employment_id;
    SQL
  end
end
