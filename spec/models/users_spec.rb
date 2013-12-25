require "spec_helper"

describe User do
  it "create new user" do
    lindeman = User.create!(username: "Andy", email: 'andy@here.com', password: 'abc123')
  end
end
