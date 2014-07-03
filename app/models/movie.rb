class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :image, ImageUploader
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    reviews.sum(:ratings_out_of_ten)/reviews.size
  end

  def self.search(query)
    q = query
    @result = Movie.where("title like :q or description like :q or director like :q", q: q)
  end

  def self.filter_by_duration(duration)
    if duration == '0'
      self.all
    elsif duration == '1'
      self.where("movies.runtime_in_minutes <= 90")
    elsif duration == '2'
      self.where("movies.runtime_in_minutes BETWEEN 90 AND 120")
    elsif duration == '3'
      self.where("movies.runtime_in_minutes >= 120")
    end
  end
  
  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

  

end
