require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:status => "Makers Academy http://www.makersacademy.com")
  
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Makers Academy http://www.makersacademy.com")
  end
end