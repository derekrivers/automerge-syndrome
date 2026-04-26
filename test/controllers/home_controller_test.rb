# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "serves the FitnessFormula landing page" do
    get root_url

    assert_response :success
    assert_select "h1", text: /Build strength, confidence, and habits/
    assert_select "a", text: "Book a session", minimum: 2

    expected_sections = %w[hero services personal-training group-classes nutrition-coaching testimonials booking]
    assert_select "main section", count: expected_sections.length
    expected_sections.each_with_index do |section_id, index|
      assert_select "main section:nth-of-type(#{index + 1})##{section_id}"
    end
  end
end
