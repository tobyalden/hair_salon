require('spec_helper')

describe(Client) do

  describe('#initialize') do
    it("Creates a new stylist.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      expect(test_client.class).to(eq(Client))
    end
  end

  describe('#id') do
    it("Returns the database ID of the stylist.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      expect(test_client.id).to(eq(nil))
    end
  end

  describe('#name') do
    it("Returns the name of the stylist.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      expect(test_client.name).to(eq("Jeremy"))
    end
  end

  describe('.all') do
    it("Returns all the stylists in the database.") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('.find') do
    it("Returns the stylist in the database with the given ID") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      test_client.save()
      expect(Client.find(test_client.id)).to(eq(test_client))
    end
  end

  describe('#save') do
    it("Saves the stylist to the database.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe('#update') do
    it("Updates the stylist's name in the database.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      test_client.save()
      test_client.update({:name => "Mary"})
      expect(Client.find(test_client.id).name).to(eq("Mary"))
    end
  end

  describe('#delete') do
    it("Deletes the stylist from the database.") do
      test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
      test_client.save()
      test_client.delete()
      expect(Client.all()).to(eq([]))
    end
  end

end
