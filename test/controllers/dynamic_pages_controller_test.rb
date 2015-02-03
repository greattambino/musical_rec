require 'test_helper'

class DynamicPagesControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "MusicalRec"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "A Hub Of Cover Songs From Talented Artists Who Deserve Musical Recognition | #{@base_title}"
  end

  test "should get artist" do
    get :artist
    assert_response :success
    assert_select "title", "Artists | #{@base_title}"
  end

end
