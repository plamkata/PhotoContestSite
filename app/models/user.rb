
require 'digest/sha1'

class User < ActiveRecord::Base

  validates_presence_of(:loginame, :message => "Не е въведено потребителско име!")
  validates_presence_of(:password, :message => "Не е въведена парола!")
  validates_presence_of(:email, :message => "Няма въведен e-mail адрес!")
  validates_presence_of(:register_date, :message => "Не е зададена дата на регистрация!")
  validates_length_of(:loginame, :maximum => 50, :message => "Потребителското име трябва да е до 50 символа!")
  validates_length_of(:pass, :maximum => 50, :message => "Паролата трябва да е до 50 символа!")
  validates_length_of(:pass, :minimum => 4, :message => "Паролата трябва да съдържа поне 4 символа!")
  validates_length_of(:email, :maximum => 100, :message => "Email-ът трябва да е до 100 символа!")
  validates_length_of(:first_name, :maximum => 100, :message => "Името трябва да е до 100 символа!")
  validates_length_of(:last_name, :maximum => 100, :message => "Фамилията трябва да е до 100 символа!")
  validates_length_of(:person_activity, :maximum => 100, :message => "Дейността трябва да е до 100 символа!")
  validates_format_of(:email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Въведеният email е невалиден!")
  validates_uniqueness_of(:loginame, :message => "Вече има потребител с това потребителско име!")
  validates_uniqueness_of(:email, :message => "Вече има потребител с този email!")
  
  attr_accessor :pass_confirmation
  validates_confirmation_of(:pass, :message => "Потвърдената парола не е същата!")
  
  has_many :pictures
  
  has_many :user_ratings
  
  def self.authenticate(loginame, password)
    user = self.find_by_loginame(loginame)
    if user
      expected_password = encrypted_password(password, user.password_salt)
      if user.password != expected_password
        user = nil
      end
    end
    user
  end
  
  # 'pass' is a virtual attribute
  def pass
    @pass
  end

  def pass=(pwd)
    if !pwd.empty?
      @pass = pwd
      self.password_salt = create_new_salt
      self.password = User.encrypted_password(@pass, self.password_salt)
    end   
  end
  
  private 
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wobble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.object_id.to_s + rand.to_s
  end
  
end
