class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.text :content
      t.integer :parent
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
