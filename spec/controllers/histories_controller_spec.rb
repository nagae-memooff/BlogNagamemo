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

describe HistoriesController do

  # This should return the minimal set of attributes required to create a valid
  # History. As you add validations to History, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "total_price" => "1.5" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HistoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all histories as @histories" do
      history = History.create! valid_attributes
      get :index, {}, valid_session
      assigns(:histories).should eq([history])
    end
  end

  describe "GET show" do
    it "assigns the requested history as @history" do
      history = History.create! valid_attributes
      get :show, {:id => history.to_param}, valid_session
      assigns(:history).should eq(history)
    end
  end

  describe "GET new" do
    it "assigns a new history as @history" do
      get :new, {}, valid_session
      assigns(:history).should be_a_new(History)
    end
  end

  describe "GET edit" do
    it "assigns the requested history as @history" do
      history = History.create! valid_attributes
      get :edit, {:id => history.to_param}, valid_session
      assigns(:history).should eq(history)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new History" do
        expect {
          post :create, {:history => valid_attributes}, valid_session
        }.to change(History, :count).by(1)
      end

      it "assigns a newly created history as @history" do
        post :create, {:history => valid_attributes}, valid_session
        assigns(:history).should be_a(History)
        assigns(:history).should be_persisted
      end

      it "redirects to the created history" do
        post :create, {:history => valid_attributes}, valid_session
        response.should redirect_to(History.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved history as @history" do
        # Trigger the behavior that occurs when invalid params are submitted
        History.any_instance.stub(:save).and_return(false)
        post :create, {:history => { "total_price" => "invalid value" }}, valid_session
        assigns(:history).should be_a_new(History)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        History.any_instance.stub(:save).and_return(false)
        post :create, {:history => { "total_price" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested history" do
        history = History.create! valid_attributes
        # Assuming there are no other histories in the database, this
        # specifies that the History created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        History.any_instance.should_receive(:update).with({ "total_price" => "1.5" })
        put :update, {:id => history.to_param, :history => { "total_price" => "1.5" }}, valid_session
      end

      it "assigns the requested history as @history" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => valid_attributes}, valid_session
        assigns(:history).should eq(history)
      end

      it "redirects to the history" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => valid_attributes}, valid_session
        response.should redirect_to(history)
      end
    end

    describe "with invalid params" do
      it "assigns the history as @history" do
        history = History.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        History.any_instance.stub(:save).and_return(false)
        put :update, {:id => history.to_param, :history => { "total_price" => "invalid value" }}, valid_session
        assigns(:history).should eq(history)
      end

      it "re-renders the 'edit' template" do
        history = History.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        History.any_instance.stub(:save).and_return(false)
        put :update, {:id => history.to_param, :history => { "total_price" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested history" do
      history = History.create! valid_attributes
      expect {
        delete :destroy, {:id => history.to_param}, valid_session
      }.to change(History, :count).by(-1)
    end

    it "redirects to the histories list" do
      history = History.create! valid_attributes
      delete :destroy, {:id => history.to_param}, valid_session
      response.should redirect_to(histories_url)
    end
  end

end
