RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.start
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
    if example.metadata[:js]
      DatabaseCleaner.strategy = :transaction
    end
  end

end