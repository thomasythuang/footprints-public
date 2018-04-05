require 'simplecov'

SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require './lib/ar_repository/ar_repository'
require 'devise'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.mock_with :rspec
  config.use_transactional_fixtures = true
  I18n.enforce_available_locales = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  #config.profile_examples = true # uncomment if profiling is necessary

  config.before(:each) do
    ApplicationController.any_instance.stub(:authenticate_user!)
  end

  config.before(:all) do
    Footprints::Repository.craftsman.destroy_all
    Footprints::Repository.applicant.destroy_all
    Footprints::Repository.assigned_craftsman_record.destroy_all
  end
end

OmniAuth.config.test_mode = true

