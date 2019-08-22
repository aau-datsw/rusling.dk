class Page < ApplicationRecord
  belongs_to :educational_domain

  has_many :accordion_items
  accepts_nested_attributes_for :accordion_items, allow_destroy: true

  validates_format_of :slug, with: %r{\A[\w/]{0,}\z}
  validates_uniqueness_of :slug, scope: :educational_domain_id
end
