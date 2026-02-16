class Reservation < ApplicationRecord
  belongs_to :guest, class_name: "User", foreign_key: "user_id"
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_after_start
  validate :no_overlap

  def duration
    (end_date.to_i - start_date.to_i) / 86400
  end

  private

  def end_after_start
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def no_overlap
    return if listing.nil? || start_date.blank? || end_date.blank?
    if listing.overlaping_reservation?(start_date, end_date)
      errors.add(:base, "Listing already booked for these dates")
    end
  end
end