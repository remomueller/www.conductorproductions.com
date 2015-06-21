class Category < ActiveRecord::Base

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :name, :slug, :position, :project_id, :user_id
  validates_uniqueness_of :slug, scope: [ :project_id, :deleted ]
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/

  # Model Relationships
  belongs_to :project
  belongs_to :user

  # Category Methods

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("categories.slug = ? or categories.id = ?", input.to_s, input.to_i).first
  end

end
