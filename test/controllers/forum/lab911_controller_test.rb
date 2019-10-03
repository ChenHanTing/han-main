require 'test_helper'

class Forum::Lab911ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forum_lab911_index_url
    assert_response :success
  end

  test "should get show" do
    get forum_lab911_show_url
    assert_response :success
  end

  test "should get edit" do
    get forum_lab911_edit_url
    assert_response :success
  end

end
