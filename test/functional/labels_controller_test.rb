require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:labels)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_label
    assert_difference('Label.count') do
      post :create, :label => { }
    end

    assert_redirected_to label_path(assigns(:label))
  end

  def test_should_show_label
    get :show, :id => labels(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => labels(:one).id
    assert_response :success
  end

  def test_should_update_label
    put :update, :id => labels(:one).id, :label => { }
    assert_redirected_to label_path(assigns(:label))
  end

  def test_should_destroy_label
    assert_difference('Label.count', -1) do
      delete :destroy, :id => labels(:one).id
    end

    assert_redirected_to labels_path
  end
end
