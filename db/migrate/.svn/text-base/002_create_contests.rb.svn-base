class CreateContests < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.column :title, :string, :limit => 200, :null => false
      t.column :description, :text, :limit => 1024
      t.column :start_date, :timestamp
      t.column :end_date, :timestamp
      t.column :is_visible, :integer, :limit => 1
      t.column :max_user_pictures, :integer, :limit => 4
      t.column :max_user_votes, :integer, :limit => 4
    end
    
    add_index :contests, :title, :unique => true
  end

  def self.down
    drop_table :contests
  end
end
