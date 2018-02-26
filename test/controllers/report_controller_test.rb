require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get filter" do
    get report_filter_url
    assert_response :success
  end

end
