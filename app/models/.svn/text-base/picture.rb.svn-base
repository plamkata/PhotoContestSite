
class Picture < ActiveRecord::Base

  validates_presence_of(:user_id, :message => "Снимката няма потребител!")
  validates_presence_of(:name, :message => "Не е въведено име за снимката!")
#  validates_presence_of(:format, :message => "Няма въведен за снимката!")
  validates_length_of(:name, :maximum => 200, :message => "Въведеното име е прекалено дълго.")
#  validates_length_of(:format, :maximum => 5, :message => "Въведения формат е прекалено дълъг!")
  validates_length_of(:comment, :maximum => 30, :message => "Въведеното описание е прекалено дълго!")
#  validates_uniqueness_of([:user, :name], :message => "Вече имате снимка с това име!")
#  validates_format_of(:format, :with => %r{^(gif|jpe?g|png)$}i, 
#    :message => "Подържат се само следните формати на картинки: gif, jpg и png!")
  
  belongs_to :user
  
  belongs_to :contest
  
  has_many :user_ratings
  
  file_column :name, :magick => { 
      :geometry => "840x680>", 
      :versions => { "thumb" => "120x120"}
  }, 
  :web_root => "files/", 
  :root_path => File.join(RAILS_ROOT, "public", "files")
  
  
end
