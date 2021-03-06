require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do 

    get root_path
    assert_template 'videos/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", artist_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end
end
