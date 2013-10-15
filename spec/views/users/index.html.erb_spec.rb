require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :name => "Name",
        :email => "Email",
        :pwd => "Pwd",
        :mood => "Mood"
      ),
      stub_model(User,
        :name => "Name",
        :email => "Email",
        :pwd => "Pwd",
        :mood => "Mood"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Pwd".to_s, :count => 2
    assert_select "tr>td", :text => "Mood".to_s, :count => 2
  end
end
