require 'spec_helper'

describe Peep do

  context "Demonstration of how datamapper works" do

    # This is not a real test, it's simply a demo of how it works
    it 'should be created and then retrieved from the db' do
      # In the beginning our database is empty, so there are no links
      expect(Peep.count).to eq(0)
      Peep.create(:status => "Makers Academy http://www.makersacademy.com/")
      expect(Peep.count).to eq(1)
      peep = Peep.first
      expect(peep.status).to eq("Makers Academy http://www.makersacademy.com/")
  
      # If we want to, we can destroy it
      peep.destroy
      # so now we have no links in the database
      expect(Peep.count).to eq(0)
    end

  end

end
