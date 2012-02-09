require 'test_helper'

module Blogel
  class PostsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
    test "should get show" do
      get :show
      assert_response :success
    end
  
    test "should get comment" do
      get :comment
      assert_response :success
    end
  
  end
end
