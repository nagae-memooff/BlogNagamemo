require 'spec_helper'

describe "file_records/new" do
  before(:each) do
    assign(:file_record, stub_model(FileRecord).as_new_record)
  end

  it "renders new file_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", file_records_path, "post" do
    end
  end
end
