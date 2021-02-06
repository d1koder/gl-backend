class AddLocationToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :location, :string
  end
end
