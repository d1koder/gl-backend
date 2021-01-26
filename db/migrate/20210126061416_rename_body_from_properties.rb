class RenameBodyFromProperties < ActiveRecord::Migration[6.0]
  def change
      rename_column :properties, :body, :description
      change_column :properties, :description, :text
  end
end
