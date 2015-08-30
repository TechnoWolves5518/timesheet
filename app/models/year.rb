class Year < ActiveRecord::Base
  attr_accessible :build_season_start, :year_end, :year_start
  
  has_many :timelogs
  has_many :users, :through => :timelogs
  has_many :hour_overrides
  has_many :hour_exceptions
  has_many :week_exceptions
  
  def is_current_year?
    if !Year.current_year.nil? && Year.current_year.id == self.id
      return true
    end
    return false
  end
  def self.current_year
    year = Year.where("year_start <= ? and year_end >= ?",Date.today,Date.today).first
    if year.nil?
      return Year.new
    end
    return year
  end
  def self.find_year(date)
    year = Year.where("year_start <= ? and year_end >= ?",date,date).first
  end
  def year_range
    "#{self.year_start.year} - #{self.year_end.year}"
  end
end
