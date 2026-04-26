# frozen_string_literal: true

require "application_system_test_case"

class LandingPageTest < ApplicationSystemTestCase
  test "root landing page renders all required section headings" do
    visit root_path

    assert_text "Build strength, confidence, and habits that actually fit your life."
    assert_text "A complete formula for sustainable fitness."
    assert_text "Your plan, your pace, expert eyes every step."
    assert_text "Show up for the room. Leave stronger for yourself."
    assert_text "Fuel that supports real life."
    assert_text "Members feel the difference in and out of the gym."
    assert_text "Ready to find your formula?"
  end
end
