FactoryBot.define do
  factory :educational_domain do
    domain { 'localhost' }
    name { 'testdomain' }
    colors do
      { primary_color: '#FFFFFF', secondary_color: '#000000' }
    end
    educations { %w[uddannelse1 uddannelse2 uddannelse3] }
    locale { 'da' }
    association :campus
  end
end
