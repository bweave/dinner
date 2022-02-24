require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: ENV["DRIVER"]&.to_sym || :headless_chrome, screen_size: [1400, 1400]

  def login(user)
    visit login_url
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"
    assert_text "Logged in"
  end
end
