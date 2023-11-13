require "test_helper"

class GroupUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get group_users_create_url
    assert_response :success
  end
end
