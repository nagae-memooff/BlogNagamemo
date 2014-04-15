require "spec_helper"

describe OfflineDownloadRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/offline_download_records").should route_to("offline_download_records#index")
    end

    it "routes to #new" do
      get("/offline_download_records/new").should route_to("offline_download_records#new")
    end

    it "routes to #show" do
      get("/offline_download_records/1").should route_to("offline_download_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/offline_download_records/1/edit").should route_to("offline_download_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/offline_download_records").should route_to("offline_download_records#create")
    end

    it "routes to #update" do
      put("/offline_download_records/1").should route_to("offline_download_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/offline_download_records/1").should route_to("offline_download_records#destroy", :id => "1")
    end

  end
end
