require 'test_helper'

class Forum::LabForumControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forum_lab_forum_index_url
    assert_response :success
  end

  test "should get show" do
    get forum_lab_forum_show_url
    assert_response :success
  end

  test "should get edit" do
    get forum_lab_forum_edit_url
    assert_response :success
  end

end
