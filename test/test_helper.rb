ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module CurrentTestHelp
  extend ActiveSupport::Concern

  class_methods do
    def with_household(fixture_name_or_nil)
      setup { with_household(fixture_name_or_nil) }
    end
  end

  included do
    teardown { Current.reset }
  end

  def with_household(fixture_name_or_nil)
    household = fixture_name_or_nil && households(fixture_name_or_nil)

    if block_given?
      Current.set(household: household) { yield }
    else
      Current.household = household
    end
  end

  def with_user(fixture_name_or_nil)
    user = fixture_name_or_nil && users(fixture_name_or_nil)

    if block_given?
      Current.set(user: user) { yield }
    else
      Current.user = user
    end
  end
end

class ActiveSupport::TestCase
  include CurrentTestHelp

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def login(user)
    post login_url, params: { user: { email: user.email, password: "password" } }
  end
end
