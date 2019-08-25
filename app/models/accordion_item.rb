class AccordionItem < ApplicationRecord
  belongs_to :page
  has_one :educational_domain, through: :page

  default_scope -> { order :position }
end
