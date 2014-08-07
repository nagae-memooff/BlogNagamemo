require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe HisMatsController do

  # This should return the minimal set of attributes required to create a valid
  # HisMat. As you add validations to HisMat, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "history_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HisMatsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all his_mats as @his_mats" do
      his_mat = HisMat.create! valid_attributes
      get :index, {}, valid_session
      assigns(:his_mats).should eq([his_mat])
    end
  end

  describe "GET show" do
    it "assigns the requested his_mat as @his_mat" do
      his_mat = HisMat.create! valid_attributes
      get :show, {:id => his_mat.to_param}, valid_session
      assigns(:his_mat).should eq(his_mat)
    end
  end

  describe "GET new" do
    it "assigns a new his_mat as @his_mat" do
      get :new, {}, valid_session
      assigns(:his_mat).should be_a_new(HisMat)
    end
  end

  describe "GET edit" do
    it "assigns the requested his_mat as @his_mat" do
      his_mat = HisMat.create! valid_attributes
      get :edit, {:id => his_mat.to_param}, valid_session
      assigns(:his_mat).should eq(his_mat)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new HisMat" do
        expect {
          post :create, {:his_mat => valid_attributes}, valid_session
        }.to change(HisMat, :count).by(1)
      end

      it "assigns a newly created his_mat as @his_mat" do
        post :create, {:his_mat => valid_attributes}, valid_session
        assigns(:his_mat).should be_a(HisMat)
        assigns(:his_mat).should be_persisted
      end

      it "redirects to the created his_mat" do
        post :create, {:his_mat => valid_attributes}, valid_session
        response.should redirect_to(HisMat.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved his_mat as @his_mat" do
        # Trigger the behavior that occurs when invalid params are submitted
        HisMat.any_instance.stub(:save).and_return(false)
        post :create, {:his_mat => { "history_id" => "invalid value" }}, valid_session
        assigns(:his_mat).should be_a_new(HisMat)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        HisMat.any_instance.stub(:save).and_return(false)
        post :create, {:his_mat => { "history_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested his_mat" do
        his_mat = HisMat.create! valid_attributes
        # Assuming there are no other his_mats in the database, this
        # specifies that the HisMat created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        HisMat.any_instance.should_receive(:update).with({ "history_id" => "1" })
        put :update, {:id => his_mat.to_param, :his_mat => { "history_id" => "1" }}, valid_session
      end

      it "assigns the requested his_mat as @his_mat" do
        his_mat = HisMat.create! valid_attributes
        put :update, {:id => his_mat.to_param, :his_mat => valid_attributes}, valid_session
        assigns(:his_mat).should eq(his_mat)
      end

      it "redirects to the his_mat" do
        his_mat = HisMat.create! valid_attributes
        put :update, {:id => his_mat.to_param, :his_mat => valid_attributes}, valid_session
        response.should redirect_to(his_mat)
      end
    end

    describe "with invalid params" do
      it "assigns the his_mat as @his_mat" do
        his_mat = HisMat.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HisMat.any_instance.stub(:save).and_return(false)
        put :update, {:id => his_mat.to_param, :his_mat => { "history_id" => "invalid value" }}, valid_session
        assigns(:his_mat).should eq(his_mat)
      end

      it "re-renders the 'edit' template" do
        his_mat = HisMat.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HisMat.any_instance.stub(:save).and_return(false)
        put :update, {:id => his_mat.to_param, :his_mat => { "history_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested his_mat" do
      his_mat = HisMat.create! valid_attributes
      expect {
        delete :destroy, {:id => his_mat.to_param}, valid_session
      }.to change(HisMat, :count).by(-1)
    end

    it "redirects to the his_mats list" do
      his_mat = HisMat.create! valid_attributes
      delete :destroy, {:id => his_mat.to_param}, valid_session
      response.should redirect_to(his_mats_url)
    end
  end

end