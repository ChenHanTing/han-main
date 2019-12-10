require 'test_helper'

class NameControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get name_index_url
    assert_response :success
  end

end
