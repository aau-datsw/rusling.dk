class DomainImage < ApplicationRecord
  belongs_to :educational_domain
  has_one_attached :image
end
