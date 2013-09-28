require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs in" do

  before(:each) do
    User.create(:email => "alice@example.com", 
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, alice@example.com")    
    sign_in('alice@example.com', 'test')
    expect(page).to have_content("Welcome, alice@example.com") 
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, alice@example.com")       
    sign_in('alice@example.com', 'wrong')
    expect(page).not_to have_content("Welcome, alice@example.com")       
  end


end