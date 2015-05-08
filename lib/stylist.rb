class Stylist

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    db_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    db_stylists.each() do |db_stylist|
      id = db_stylist.fetch('id').to_i()
      name = db_stylist.fetch('name')
      stylists.push(Stylist.new({:id => id, :name => name}))
    end
    stylists
  end

  define_singleton_method(:find) do |find_id|
    db_stylist = DB.exec("SELECT * FROM stylists WHERE id = #{find_id}")
    id = db_stylist.first().fetch('id').to_i()
    name = db_stylist.first().fetch('name')
    return Stylist.new({:id => id, :name => name})
  end

  define_method(:==) do |another_stylist|
    return @name == another_stylist.name
  end

  define_method(:save) do
    db_id = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = db_id.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes[:name]
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{@id}")
  end

end
