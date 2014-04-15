require 'spec_helper'

describe "offline_download_records/new" do
  before(:each) do
    assign(:offline_download_record, stub_model(OfflineDownloadRecord,
      :url => "MyString",
      :file_name => "MyString",
      :retry_times => 1,
      :user_id => 1,
      :status => 1
    ).as_new_record)
  end

  it "renders new offline_download_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offline_download_records_path, "post" do
      assert_select "input#offline_download_record_url[name=?]", "offline_download_record[url]"
      assert_select "input#offline_download_record_file_name[name=?]", "offline_download_record[file_name]"
      assert_select "input#offline_download_record_retry_times[name=?]", "offline_download_record[retry_times]"
      assert_select "input#offline_download_record_user_id[name=?]", "offline_download_record[user_id]"
      assert_select "input#offline_download_record_status[name=?]", "offline_download_record[status]"
    end
  end
end
