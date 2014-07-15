require 'test_helper'

class Api::HelpfulControllerTest < ActionController::TestCase
  test "should get submit" do
    get :submit, guid: "12345", value: "true", url: "http://www.salas.com"
    assert_response :success
    JSON.parse(response.body).class.must_equal Array
  end

  test "should get get" do
    get :get, email: "iam@gmail.com", guid:"12345", url: "http://www.salas.com"
    assert_response :success
    response.body.must_equal "false"
  end

end
