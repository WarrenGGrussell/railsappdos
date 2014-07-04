class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
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

  scope :runtime_all, -> { where("runtime_in_minutes > 0") }
  scope :runtime_90_min, -> { where("runtime_in_minutes <= 90") }
  scope :runtime_between, -> { where("runtime_in_minutes BETWEEN 90 AND 120") } 
  scope :runtime_120_min, -> { where("runtime_in_minutes >= 120") }

  def review_average
    reviews.sum(:ratings_out_of_ten)/reviews.size
  end

  def self.search(query)
    q = query
    @result = Movie.where("title like :q or description like :q or director like :q", q: q)
  end

#define and use scopes in the Movie model and call on them from the controller.


  def self.filter_by_duration(duration)
    if duration == '0'
      self.all
    elsif duration == '1'
      self.runtime_90_min
    elsif duration == '2'
      self.runtime_between
    elsif duration == '3'
      self.runtime_120_min
    end
  end
  
  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

  

end
