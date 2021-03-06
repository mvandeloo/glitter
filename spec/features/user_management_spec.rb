require 'spec_helper'

feature "User signs up" do

  
  scenario "when being logged out" do    
    lambda { sign_up }.should change(User, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")        
  end




  scenario "with a password that doesn't match" do
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0)   
    expect(current_path).to eq('/users')   
    expect(page).to have_content("Password does not match the confirmation") 
  end

  def sign_up(email = "alice@example.com", 
              password = "oranges!", 
              password_confirmation = 'oranges!',  
              name = "alice", 
              username = "wonderland_alice")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    fill_in :name, :with => name
    # fill_in :username, :with => username
    click_button "Sign up"
  end

  scenario "with an email that is already registered" do    
    lambda { sign_up }.should change(User, :count).by(1)
    lambda { sign_up }.should change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

end