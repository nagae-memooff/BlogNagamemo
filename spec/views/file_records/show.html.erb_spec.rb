require 'spec_helper'

describe "file_records/show" do
  before(:each) do
    @file_record = assign(:file_record, stub_model(FileRecord))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
