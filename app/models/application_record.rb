class ApplicationRecord < ActiveRecord::Base
  include HasJsonEditable

  self.abstract_class = true
end
