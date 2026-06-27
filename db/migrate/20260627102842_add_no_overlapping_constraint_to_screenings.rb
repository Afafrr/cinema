class AddNoOverlappingConstraintToScreenings < ActiveRecord::Migration[8.1]
  def up
    enable_extension "btree_gist"

    execute <<~SQL
      ALTER TABLE screenings
      ADD CONSTRAINT no_overlapping_screenings
      EXCLUDE USING gist (
        room_id WITH =,
        tsrange(starts_at, ends_at, '[)') WITH &&
      );
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE screenings
      DROP CONSTRAINT no_overlapping_screenings;
    SQL
  end
end
