class Menu < ApplicationRecord
  belongs_to :educational_domain
  has_many :menu_items
  accepts_nested_attributes_for :menu_items, allow_destroy: true
  # {"link"=>"/faq", "name"=>"Vigtig viden", "image_url"=>"menu/vigtigviden.png", "description"=>"Ligegyldig info"}
end
