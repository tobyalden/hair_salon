require('spec_helper')

describe(Stylist) do

  describe('#initialize') do
    it("Creates a new stylist.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      expect(test_stylist.class).to(eq(Stylist))
    end
  end

  describe('#id') do
    it("Returns the database ID of the stylist.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      expect(test_stylist.id).to(eq(nil))
    end
  end

  describe('#name') do
    it("Returns the name of the stylist.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      expect(test_stylist.name).to(eq("Ray"))
    end
  end

  describe('.all') do
    it("Returns all the stylists in the database.") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('.find') do
    it("Returns the stylist in the database with the given ID") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      test_stylist.save()
      expect(Stylist.find(test_stylist.id)).to(eq(test_stylist))
    end
  end

  describe('#save') do
    it("Saves the stylist to the database.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('#update') do
    it("Updates the stylist's name in the database.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      test_stylist.save()
      test_stylist.update({:name => "Tina"})
      expect(Stylist.find(test_stylist.id).name).to(eq("Tina"))
    end
  end

  describe('#delete') do
    it("Deletes the stylist from the database.") do
      test_stylist = Stylist.new({:id => nil, :name => "Ray"})
      test_stylist.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end

end
