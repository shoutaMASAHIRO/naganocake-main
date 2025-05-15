class AddIsDeletedToGenres < ActiveRecord::Migration[6.1]
    def change
      add_column :genres, :is_deleted, :boolean, default: false, null: false
    end
end