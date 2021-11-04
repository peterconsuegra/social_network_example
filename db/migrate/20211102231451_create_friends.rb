class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      
      t.belongs_to :user
      t.integer :target_id
      t.boolean :status

      t.timestamps
    end
  end
end
