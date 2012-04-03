class CreateValues < ActiveRecord::Migration
  def self.up
    create_table :values do |t|
      t.integer :page_id
      t.integer :field_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :values
  end
end
