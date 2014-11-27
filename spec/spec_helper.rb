require 'rubygems'
require File.expand_path('../support/log_in_support.rb', __FILE__)

rubymine = "/Applications/Rubymine.app"
if File.exist?(rubymine)
  $LOAD_PATH.unshift(File.expand_path("rb/testing/patch/common", rubymine))
  $LOAD_PATH.unshift(File.expand_path("rb/testing/patch/bdd", rubymine))
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
ENV["SKIP_RAILS_ADMIN_INITIALIZER"] = "false"
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'resque_spec/scheduler'
require 'webmock/rspec'
#require 'codeclimate-test-reporter'
#require 'billy/rspec'

ActiveRecord::Migration.maintain_test_schema!

if ENV['JENKINS_HOME']
  CodeClimate::TestReporter.start
end

#WebMock.disable_net_connect!(allow_localhost: true, allow: "codeclimate.com/test_reports")

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

#ENV['SD_PROXY'] = 'true' # uncomment this line when running in rubymine behind the proxy
#Capybara.javascript_driver = ENV['SD_PROXY'] ? :webkit_billy : :webkit

RSpec.configure do |config|
  # If you want to run integration specs locally, comment out the next line temporarily and set the STACK_TARGET env var
  config.filter_run_excluding :require_network => true

  # This is an example of how to run the integration specs on a specific stack
  #ENV['STACK_TARGET'] = 'acceptance'

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  #config.include BusinessLogicAcceptanceExampleGroup,
                 #example_group: {file_path: %r(spec/business_logic_acceptance)}

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include LogInSupport, type: :request
  config.include LogInSupport, type: :feature
  #config.include IntegrationServiceLocatorStubs
  #config.include IncommRequestStubs
  #config.include InstantinkSpecHelpers::TextFixtureLoading
  #InstantinkSpecHelpers::TextFixtureLoading.fixture_path = File.expand_path('../fixtures', __FILE__)

  config.before(:suite) do
    #DatabaseCleaner.clean_with :truncation
    #load Rails.root.join('db', 'app_setting_seeds.rb')
  end

  config.include Capybara::DSL

  config.include Rails.application.routes.url_helpers

  config.infer_spec_type_from_file_location!
end

module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end
