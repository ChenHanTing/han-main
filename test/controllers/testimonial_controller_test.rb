require 'test_helper'

class TestimonialControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get testimonial_index_url
    assert_response :success
  end

end
