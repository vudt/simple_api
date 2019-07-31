class RenamePostIdToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :post_id, :user_id
  end
end
