require "spec_helper"

describe FileRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/file_records").should route_to("file_records#index")
    end

    it "routes to #new" do
      get("/file_records/new").should route_to("file_records#new")
    end

    it "routes to #show" do
      get("/file_records/1").should route_to("file_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/file_records/1/edit").should route_to("file_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/file_records").should route_to("file_records#create")
    end

    it "routes to #update" do
      put("/file_records/1").should route_to("file_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/file_records/1").should route_to("file_records#destroy", :id => "1")
    end

  end
end
