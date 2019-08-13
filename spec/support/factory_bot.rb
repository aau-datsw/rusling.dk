RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |_example|
    DatabaseCleaner.start
  end

  config.after(:each) do |_example|
    DatabaseCleaner.clean
  end
end
