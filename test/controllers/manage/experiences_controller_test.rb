require 'test_helper'

describe Manage::ExperiencesController do
  before { sign_in create(:user) }

  describe 'a POST to #create' do
    describe 'with valid attributes' do
      before { post :create, experience: attributes_for(:experience) }

      it 'should render successfully with flash' do
        assert_response :redirect
        assert_flash :success
      end
    end

    describe 'with invalid attributes' do
      before { post :create, experience: { name: nil } }

      it 'should render #new' do
        assert_response :success
        assert_template :new
        assert_flash :error
      end
    end
  end

  describe 'a GET to #new' do
    before { get :new }

    it 'should render successfully' do
      assert_response :success
      assert_template :new
    end
  end
end
