class Menu < ApplicationRecord
  belongs_to :educational_domain

  has_json_editable(
    :items,
    array: true,
    format: {
      link: :string,
      name: :string,
      image_url: :string,
      description: :string
    }
  )
  # {"link"=>"/faq", "name"=>"Vigtig viden", "image_url"=>"menu/vigtigviden.png", "description"=>"Ligegyldig info"}
end
