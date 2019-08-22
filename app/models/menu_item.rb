class MenuItem < ApplicationRecord
  belongs_to :menu
  has_one :educational_domain, through: :menu
end
