# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "serves the home page" do
    get root_url
    assert_response :success
    assert_select "h1", "Rails 7 is ready"
  end
end
