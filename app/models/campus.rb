class Campus < ApplicationRecord
  has_many :educational_domains
  has_one_attached :logo
end
