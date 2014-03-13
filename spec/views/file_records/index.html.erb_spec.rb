require 'spec_helper'

describe "file_records/index" do
  before(:each) do
    assign(:file_records, [
      stub_model(FileRecord),
      stub_model(FileRecord)
    ])
  end

  it "renders a list of file_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
