class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.integer :author_id
      t.integer :article_id
      t.string   :asset_file_name
      t.string   :asset_content_type
      t.integer  :asset_file_size
      t.datetime :asset_updated_at
    end
    add_index :attachments, [:attachable_type, :attachable_id]
    add_index :attachments, :article_id
  end
end
