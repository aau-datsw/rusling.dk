class Event < ApplicationRecord
  belongs_to :educational_domain

  scope :upcoming, -> { where('DATE(begin_at) > ?', Date.today) }
  scope :today, -> { where('DATE(begin_at) = ?', Date.today) }
  scope :previous, -> { where('DATE(begin_at) < ?', Date.today) }

  def pretty_display
    "#{self.title} - #{I18n.l(self.begin_at)}"
  end
end
