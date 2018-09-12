require 'rails_helper'

RSpec.describe Sponsor, type: :model do
  it { should belong_to(:educational_domain) }
end
