class AddProfileFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :likes, :text
    add_column :users, :dislikes, :text
    add_column :users, :birth, :date
    add_column :users, :web, :string
  end
end
