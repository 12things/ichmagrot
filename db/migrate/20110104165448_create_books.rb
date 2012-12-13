# -*- encoding : utf-8 -*-
class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.text :field_ids
      t.integer :user_id
      t.string :template
      t.integer :progress, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
