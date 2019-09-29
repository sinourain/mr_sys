ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'factory_bot'
require './main'


Dir[('./spec/support/**/*.rb')].each { |file| require file }

# monkey-patching Sequel::Model to allow FactoryGirl to call #save!
Sequel::Model.send :alias_method, :save!, :save

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    existing_tables = Sequel::Model.db.tables
    tables_to_preserve = [:schema_info, :schema_migrations]
    tables_to_be_emptied = existing_tables - tables_to_preserve
    tables_to_be_emptied.each do |table|
      Sequel::Model.db[table].delete
    end
  end
end
