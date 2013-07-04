class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.column :user_id, :integer, :null => false
      t.column :contest_id, :integer
      t.column :name, :string, :limit => 200, :null => false
      t.column :format, :string, :limit => 5
      t.column :comment, :string, :limit => 512
    end
    
    add_index :pictures, [:name, :user_id], :unique => true
    
    execute "ALTER TABLE pictures ADD FOREIGN KEY fk_picture_user(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE NO ACTION"
    execute "ALTER TABLE pictures ADD FOREIGN KEY fk_picture_contest(contest_id) REFERENCES contests(id) ON DELETE CASCADE ON UPDATE NO ACTION"
    
  end

  def self.down
    drop_table :pictures
  end
end
