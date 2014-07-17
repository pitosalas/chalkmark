require 'test_helper'

class Api::HelpfulControllerTest < ActionController::TestCase
  test "should get submit" do
    get :submit, guid: "12345", value: "true", url: "http://www.salas.com", callback: "test"
    assert_response :success
    response.body.must_equal "test([1,1])"
  end

  test "should get get" do
    get :get, email: "iam@gmail.com", guid:"12345", url: "http://www.salas.com", callback: "test"
    assert_response :success
    response.body.must_equal "test(false)"
  end

end
