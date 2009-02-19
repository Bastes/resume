class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :item_id

      t.string   :content_file_name
      t.string   :content_avatar_content_type
      t.integer  :content_file_size
      t.datetime :content_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
