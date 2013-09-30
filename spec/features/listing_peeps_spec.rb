require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:status => "Learn to code", :name => "Alice", :username => "wonderland_alice")
  
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Learn to code by Alice (wonderland_alice")
  end
end