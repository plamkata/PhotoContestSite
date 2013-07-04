class Contest < ActiveRecord::Base

  has_many :pictures
  
  attr_accessor :active_at_year, :active_at_month, :active_at_day
  attr_accessor :inactive_at_year, :inactive_at_month, :inactive_at_day
  
  validates_presence_of(:title, :message => "Полето за заглавие е задължително!")
  validates_length_of(:title, :maximum => 200, :message => "Заглавието е прекалено дълго!")
  validates_length_of(:title, :minimum => 5, :message => "Заглавието трябва да съдържа поне 5 символа!")
  validates_length_of(:description, :maximum => 1024, :message => "Описанието е прекалено дълго!")
  validates_uniqueness_of(:title, :message => "Вече има конкурс с това заглавие!")
  validate(:validate_dates)
  
  before_save :create_dates
  
  def validate_dates
    if active_at_year.nil?
      return true
    end
    
    active_at_date_valid = Date::valid_civil?(active_at_year.to_i, active_at_month.to_i, active_at_day.to_i)
    inactive_at_date_valid = Date::valid_civil?(inactive_at_year.to_i, inactive_at_month.to_i, inactive_at_day.to_i)
    
    self.errors.add(:start_date, 'Невалидна начална дата!') unless active_at_date_valid
    self.errors.add(:end_date, 'Невалидна крайна дата!') unless inactive_at_date_valid

    return active_at_date_valid && inactive_at_date_valid
  end
  
  def create_dates
    self.start_date = Time.gm(self.active_at_year, self.active_at_month, self.active_at_day, 0, 0) unless active_at_year.nil?
    self.end_date = Time.gm(self.inactive_at_year, self.inactive_at_month, self.inactive_at_day, 0, 0) unless inactive_at_year.nil?
  end
  
  def load_dates
    self.active_at_year = self.start_date.year unless self.start_date.nil?
    self.active_at_month = self.start_date.month unless self.start_date.nil?
    self.active_at_day = self.start_date.day unless self.start_date.nil?
    
    self.inactive_at_year = self.end_date.year unless self.end_date.nil?
    self.inactive_at_month = self.end_date.month unless self.end_date.nil?
    self.inactive_at_day = self.end_date.day unless self.end_date.nil?
  end
  
  def start_date_formatted
    if self.start_date
      d = @attributes['start_date']
      return "#{d[8,2]}.#{d[5,2]}.#{d[0,4]}"
    else 
      return ""
    end
  end
  
  def end_date_formatted
    if self.end_date
      d = @attributes['end_date']
      return "#{d[8,2]}.#{d[5,2]}.#{d[0,4]}"
    else 
      return ""
    end
  end
  
end
