require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "MusicalRec"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "A Hub Of Cover Songs From Talented Artists Who Deserve Musical Recognition | #{@base_title}"
  end

end
