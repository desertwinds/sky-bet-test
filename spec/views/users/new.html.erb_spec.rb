require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :firstname => "MyString",
      :surname => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_firstname[name=?]", "user[firstname]"

      assert_select "input#user_surname[name=?]", "user[surname]"
    end
  end
end
