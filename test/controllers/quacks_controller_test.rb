require 'test_helper'

class QuacksControllerTest < ActionController::TestCase
  setup do
    @quack = quacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quack" do
    assert_difference('Quack.count') do
      post :create, quack: { name: @quack.name, title: @quack.title }
    end

    assert_redirected_to quack_path(assigns(:quack))
  end

  test "should show quack" do
    get :show, id: @quack
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quack
    assert_response :success
  end

  test "should update quack" do
    patch :update, id: @quack, quack: { name: @quack.name, title: @quack.title }
    assert_redirected_to quack_path(assigns(:quack))
  end

  test "should destroy quack" do
    assert_difference('Quack.count', -1) do
      delete :destroy, id: @quack
    end

    assert_redirected_to quacks_path
  end
end
