class Sponsor < ApplicationRecord
  belongs_to :educational_domain
  has_one_attached :logo
end
