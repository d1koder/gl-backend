class RenamePostsToProperties < ActiveRecord::Migration[6.0]
  def change
    rename_table :posts, :properties
  end
end
