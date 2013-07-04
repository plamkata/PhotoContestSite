class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :loginame, :string, :limit => 50, :null => false 
      t.column :password, :string, :limit => 50, :null => false
      t.column :email, :string, :limit => 100, :null => false
      t.column :is_admin, :integer, :limit => 1, :null => false, :default => 0
      t.column :register_date, :timestamp, :null => false
      t.column :first_name, :string, :limit => 100
      t.column :last_name, :string, :limit => 100
      t.column :person_activity, :string, :limit => 100
      t.column :spam, :integer, :limit => 1, :null => false, :default => 1
    end
    
    add_index :user, :loginame, :unique => true
    add_index :user, :email, :unique => true
    
  end

  def self.down
    drop_table :users
  end
end
