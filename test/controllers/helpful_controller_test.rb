require 'test_helper'

class Api::HelpfulControllerTest < ActionController::TestCase
  test "should get submit" do
    get :submit, guid: "12345", value: "true"
    assert_response :success
    items = JSON.parse(response.body)
    items["guid"].must_equal "12345"
    items["value"].must_equal "true"
  end

  test "should get get" do
    get :get, email: "iam@gmail.com", guid:"12345"
    assert_response :success
    items = JSON.parse(response.body)
    items["guid"].must_equal "12345"
    items["email"].must_equal "iam@gmail.com"
  end

end
