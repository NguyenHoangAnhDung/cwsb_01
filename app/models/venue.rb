class Venue < ApplicationRecord
  has_one :address, inverse_of: :venue
  has_many :images, as: :imageable
  has_many :user_role_venues
  has_many :roles, through: :user_role_venues
  has_many :users, through: :user_role_venues
  has_many :amenities, through: :venue_amenities
  has_many :venue_amenities
  has_many :reviews
  has_many :spaces
  has_many :working_times
  has_many :orders
  attr_accessor :user

  after_create :create_user_venue
  after_create :build_working_time
  after_create :create_user_venue, :create_default_amenity_for_venue

  validates :description, presence: true
  validates :name, presence: true

  delegate :details, to: :address, prefix: true

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :working_times, allow_destroy: true

  def create_user_venue
    user_role_venues.create user: user
  end

  def build_working_time
    WorkingTime.day_in_weeks.each do |day, value|
      self.working_times.create day_in_week: day,
        working_to: Settings.working_to, working_from: Settings.working_from,
        status: Settings.status_open
    end
  end

  def create_default_amenity_for_venue
    @default_amenities = Amenity.select_default_amenities
    unless @default_amenities.nil?
      @default_amenities.each do |default_amenity|
        venue_amenities.create venue_id: id, amenity_id: default_amenity.id
      end
    end
  end
end
