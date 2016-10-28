require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  include ApplicationHelper

    def setup
      @user = users(:michael)
    end

    test "profile display" do
      get user_path(@user)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_select 'h1', text: @user.name
      assert_select 'h1>img.gravatar'
      assert_match @user.microposts.count.to_s, response.body  # response.body contains the full HTML source of the page (and not just the page's body). It means that all we care abot is that the number of microposts appears somewhere on the page.
      assert_select 'div.pagination'
      @user.microposts.paginate(page: 1).each do |micropost|
        assert_match micropost.content, response.body
      end
      assert_select "div.pagination", count: 1
    end

end
