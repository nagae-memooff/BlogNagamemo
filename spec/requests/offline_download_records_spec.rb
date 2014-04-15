require 'spec_helper'

describe "OfflineDownloadRecords" do
  describe "GET /offline_download_records" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get offline_download_records_path
      response.status.should be(200)
    end
  end
end
