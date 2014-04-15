require 'spec_helper'

describe "offline_download_records/show" do
  before(:each) do
    @offline_download_record = assign(:offline_download_record, stub_model(OfflineDownloadRecord,
      :url => "Url",
      :file_name => "File Name",
      :retry_times => 1,
      :user_id => 2,
      :status => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/File Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
