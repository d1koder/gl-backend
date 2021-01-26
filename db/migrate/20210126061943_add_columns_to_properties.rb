class AddColumnsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :category_id, :bigint
    add_column :properties, :rate, :float
  end
end
