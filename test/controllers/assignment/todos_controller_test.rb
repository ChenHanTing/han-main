require 'test_helper'

class Assignment::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get assignment_todos_index_url
    assert_response :success
  end

  test "should get new" do
    get assignment_todos_new_url
    assert_response :success
  end

  test "should get show" do
    get assignment_todos_show_url
    assert_response :success
  end

end
