class BackfillEndsAtScreening < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      UPDATE screenings
      SET ends_at = starts_at + (
        SELECT duration_minutes
        FROM movies
        WHERE movies.id = screenings.movie_id
        ) * interval '1 minute'
        WHERE ends_at IS NULL
    SQL
  end

  def down
    execute <<~SQL
      UPDATE screenings
      SET ends_at = NULL
      WHERE ends_at IS NOT NULL
    SQL
  end
end
