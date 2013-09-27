require 'spec_helper'

feature "User adds a new peep" do
  scenario "when browsing the homepage" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("peep. peep. peep")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.status).to eq("peep. peep. peep")
  end

  def add_peep(status)
    within('#new-peep') do
      fill_in 'status', :with => status
      click_button 'add peep!'
    end      
  end
end

