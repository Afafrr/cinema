class AddUniqueIndexToScreeningStartAtAndRoom < ActiveRecord::Migration[8.1]
  def change
    add_index :screenings, [ :starts_at, :room_id ], unique: true
  end
end
