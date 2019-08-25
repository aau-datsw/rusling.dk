class MenuItem < ApplicationRecord
  belongs_to :menu
  has_one :educational_domain, through: :menu

  jsonb_accessor :colors,
    text_color: [:string, default: nil],
    overlay_color: [:string, default: nil]

  default_scope -> { order :position }
end
