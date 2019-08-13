class Page < ApplicationRecord
  belongs_to :educational_domain
  validates_format_of :slug, with: %r{\A[\w/]{0,}\z}
  validates_uniqueness_of :slug, scope: :educational_domain_id

  has_json_editable(
    :accordion,
    array: true,
    format: {
      title: :string,
      content: :string
    }
  )
end
