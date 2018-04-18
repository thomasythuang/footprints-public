class AddForeignKeysToTables < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE applicants
        ADD CONSTRAINT craftsman_id_fk
          FOREIGN KEY (craftsman_id)
          REFERENCES craftsmen (employment_id);

      ALTER TABLE assigned_craftsman_records
        ADD CONSTRAINT craftsman_id_fk
          FOREIGN KEY (craftsman_id)
          REFERENCES craftsmen (id),
        ADD CONSTRAINT applicant_id_fk
          FOREIGN KEY (applicant_id)
          REFERENCES applicants (id);

      ALTER TABLE messages
        ADD CONSTRAINT applicant_id_fk
          FOREIGN KEY (applicant_id)
          REFERENCES applicants (id);

      ALTER TABLE notes
        ADD CONSTRAINT craftsman_id_fk
          FOREIGN KEY (craftsman_id)
          REFERENCES craftsmen (id),
        ADD CONSTRAINT applicant_id_fk
          FOREIGN KEY (applicant_id)
          REFERENCES applicants (id);

      ALTER TABLE users
        ADD CONSTRAINT craftsman_id_fk
          FOREIGN KEY (craftsman_id)
          REFERENCES craftsmen (employment_id);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE applicants
        DROP CONSTRAINT craftsman_id_fk;

      ALTER TABLE assigned_craftsman_records
        DROP CONSTRAINT craftsman_id_fk,
        DROP CONSTRAINT applicant_id_fk;

      ALTER TABLE messages
        DROP CONSTRAINT applicant_id_fk;

      ALTER TABLE notes
        DROP CONSTRAINT craftsman_id_fk,
        DROP CONSTRAINT applicant_id_fk;

      ALTER TABLE users
        DROP CONSTRAINT craftsman_id_fk;
    SQL
  end
end
