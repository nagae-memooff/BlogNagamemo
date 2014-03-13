require 'spec_helper'

describe "file_records/edit" do
  before(:each) do
    @file_record = assign(:file_record, stub_model(FileRecord))
  end

  it "renders the edit file_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", file_record_path(@file_record), "post" do
    end
  end
end
