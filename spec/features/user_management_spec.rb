require 'spec_helper'

feature "User signs up" do

  
  scenario "when being logged out" do    
    lambda { sign_up }.should change(User, :count).by(1)    
    expect(page).to have_content("Welcome, motherfucker@example.com")
    expect(User.first.email).to eq("motherfucker@example.com")        
  end

  def sign_up(email = "motherfucker@example.com", 
              password = "oranges!", name = "alice", username = "wonderland_alice")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :name, :with => name
    fill_in :username, :with => username
    click_button "Sign up"
  end

end