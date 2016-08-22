# frozen_string_literal: true

# Allows photos to be added to locations.
class LocationPhoto < ApplicationRecord
  # Uploaders
  mount_uploader :photo, ResizableImageUploader

  # Model Validation
  validates :project_id, :location_id, :user_id, presence: true

  # Model Relationships
  belongs_to :project
  belongs_to :location
  belongs_to :user

  # Location Photo Methods

  def number
    location.location_photos.pluck(:id).index(id) + 1
  rescue
    -1
  end

  def next_photo
    next_index = (location.location_photos.pluck(:id).index(id) + 1 rescue -1)
    return nil if next_index < 0
    location.location_photos[next_index]
  end

  def previous_photo
    previous_index = (location.location_photos.pluck(:id).index(id) - 1 rescue -1)
    return nil if previous_index < 0
    location.location_photos[previous_index]
  end
end
