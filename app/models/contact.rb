class Contact < ApplicationRecord
  belongs_to :educational_domain
  has_one_attached :person_image
end
