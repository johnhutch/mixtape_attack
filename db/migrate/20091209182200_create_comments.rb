class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :parent_id
      t.string :parent_type
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
