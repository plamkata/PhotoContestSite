class CreateUserRatings < ActiveRecord::Migration
  def self.up
    create_table :user_ratings do |t|
      t.column :user_id, :integer, :null => false
      t.column :picture_id, :integer, :null => false
      t.column :rating, :integer, :limit => 4
    end
    
    execute "ALTER TABLE user_ratings ADD FOREIGN KEY fk_user_rating_user(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE NO ACTION"
    execute "ALTER TABLE user_ratings ADD FOREIGN KEY fk_user_rating_picture(picture_id) REFERENCES pictures(id) ON DELETE CASCADE ON UPDATE NO ACTION"
  end

  def self.down
    drop_table :user_ratings
  end
end
