require "application_system_test_case"

class DinnersTest < ApplicationSystemTestCase
  setup do
    @dinner = dinners(:one)
  end

  test "visiting the index" do
    visit dinners_url
    assert_selector "h1", text: "Dinners"
  end

  test "should create dinner" do
    visit dinners_url
    click_on "New dinner"

    fill_in "Last suggested at", with: @dinner.last_suggested_at
    fill_in "Name", with: @dinner.name
    click_on "Create Dinner"

    assert_text "Dinner was successfully created"
    click_on "Back"
  end

  test "should update Dinner" do
    visit dinner_url(@dinner)
    click_on "Edit this dinner", match: :first

    fill_in "Last suggested at", with: @dinner.last_suggested_at
    fill_in "Name", with: @dinner.name
    click_on "Update Dinner"

    assert_text "Dinner was successfully updated"
    click_on "Back"
  end

  test "should destroy Dinner" do
    visit dinner_url(@dinner)
    click_on "Destroy this dinner", match: :first

    assert_text "Dinner was successfully destroyed"
  end
end
