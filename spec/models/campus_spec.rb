require 'rails_helper'

RSpec.describe Campus, type: :model do
  it { should have_many(:educational_domains) }
end
