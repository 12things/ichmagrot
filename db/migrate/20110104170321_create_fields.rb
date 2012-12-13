# -*- encoding : utf-8 -*-
class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end
