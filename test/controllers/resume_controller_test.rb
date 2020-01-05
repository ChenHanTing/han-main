require 'test_helper'

class ResumeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get resume_show_url
    assert_response :success
  end

end
