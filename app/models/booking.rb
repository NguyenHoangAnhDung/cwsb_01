class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :booking_type

  has_one :invoice
  has_many :notifications, as: :notifiable

  enum state: {Pending: 0, Requested: 1, Rejected: 2, Accepted: 3}

  validates :booking_from, presence: true
  validates :duration, presence: true
  validates :quantity, presence: true
  validates :user, presence: true

  scope :current_order, -> (user) {where user_id: user.id}
end
