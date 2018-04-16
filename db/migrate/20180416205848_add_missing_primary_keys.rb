class AddMissingPrimaryKeys < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE craftsmen
        ADD CONSTRAINT employment_id_uniqueness UNIQUE(employment_id);

      ALTER TABLE annual_starting_craftsman_salaries
        ADD CONSTRAINT location_uniquness UNIQUE(location);

      ALTER TABLE monthly_apprentice_salaries
        ADD CONSTRAINT duration_location_uniquness UNIQUE(duration, location);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE craftsmen
        DROP CONSTRAINT employment_id_uniqueness;

      ALTER TABLE annual_starting_craftsman_salaries
        DROP CONSTRAINT location_uniquness;

      ALTER TABLE monthly_apprentice_salaries
        DROP CONSTRAINT duration_location_uniquness;
    SQL
  end
end
