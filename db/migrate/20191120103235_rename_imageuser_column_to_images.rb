class RenameImageuserColumnToImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :userimage, :image
  end
end
