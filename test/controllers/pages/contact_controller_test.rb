require 'test_helper'

class Pages::ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_contact_path
    assert_response :success
  end

end
