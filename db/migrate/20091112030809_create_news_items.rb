class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.string :tite
      t.text :body
      t.text :excerpt
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :news_items
  end
end
