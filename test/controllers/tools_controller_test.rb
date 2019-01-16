require 'test_helper'

class ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get uploadxls" do
    get tools_uploadxls_url
    assert_response :success
  end

end
