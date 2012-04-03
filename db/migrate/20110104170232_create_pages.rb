class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :position
      t.integer :book_id
      t.integer :user_id
      
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
