class UserRating < ActiveRecord::Base
  validates_presence_of(:user, :message => "Няма асоцииран потребител!")
  validates_presence_of(:picture, :message => "Няма асоциирана снимка!")
  validates_numericality_of(:rating, :only_integer => true, :message => "Гласуването е по целочислен брой точки!")
  
  belongs_to :user
  
  belongs_to :picture
  
end
