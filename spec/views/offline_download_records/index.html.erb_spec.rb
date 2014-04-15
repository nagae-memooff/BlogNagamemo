require 'spec_helper'

describe "offline_download_records/index" do
  before(:each) do
    assign(:offline_download_records, [
      stub_model(OfflineDownloadRecord,
        :url => "Url",
        :file_name => "File Name",
        :retry_times => 1,
        :user_id => 2,
        :status => 3
      ),
      stub_model(OfflineDownloadRecord,
        :url => "Url",
        :file_name => "File Name",
        :retry_times => 1,
        :user_id => 2,
        :status => 3
      )
    ])
  end

  it "renders a list of offline_download_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
