class EducationalDomain < ApplicationRecord
  # include Colorised
  has_many :menus
  has_many :events
  has_many :contacts
  has_many :sponsors

  belongs_to :primary_menu, class_name: 'Menu', optional: true
  belongs_to :secondary_menu, class_name: 'Menu', optional: true

  has_many :pages
  belongs_to :default_page, class_name: 'Page', optional: true
  # belongs_to :layout

  before_save ->(c) { c.educations.reject!(&:blank?) }

  has_json_editable(
    :colors,
    format: {
      primary_color: :string,
      secondary_color: :string
    }
  )

  def self.default_domain
    where(domain: Rails.application.config.action_controller.default_url_options[:host]).first
  end
end
