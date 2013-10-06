require 'spec_helper'

feature "User adds a new peep" do

  before(:each) do
    User.create(:email => "alice@example.com", 
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "when browsing the homepage" do
    sign_in('alice@example.com', 'test')
    expect(Peep.count).to eq(0)
    visit '/'

    add_peep("peep. peep. peep")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.status).to eq("peep. peep. peep")
  end

  def add_peep(status)
    within('#new-peep') do
      fill_in 'status', :with => "Pepp"
      fill_in 'name', :with => "Alex"
      fill_in 'username', :with => "alex"
      click_button 'add peep!'
    end      
  end

end

