require 'test_helper'

class Api::HelpfulControllerTest < ActionController::TestCase
  test "should get submit" do
    get :vote, guid: "12345", value: "true", url: "http://www.salas.com", callback: "test"
    assert_response :success
    response.body.must_equal "test({\"true\":1,\"false\":0})"
  end

  test "should get get" do
    get :voted, email: "iam@gmail.com", guid:"12345", url: "http://www.salas.com", callback: "test"
    assert_response :success
    response.body.must_equal "test(false)"
  end

end
