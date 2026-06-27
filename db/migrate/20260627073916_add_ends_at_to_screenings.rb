class AddEndsAtToScreenings < ActiveRecord::Migration[8.1]
  def change
    add_column :screenings, :ends_at, :datetime
  end
end
