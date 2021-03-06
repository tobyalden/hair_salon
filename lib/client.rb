class Client

  attr_reader(:id, :name, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @stylist_id = attributes[:stylist_id]
  end

  define_singleton_method(:all) do
    db_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    db_clients.each() do |db_client|
      id = db_client.fetch('id').to_i()
      name = db_client.fetch('name')
      stylist_id = db_client.fetch('stylist_id').to_i()
      clients.push(Client.new({:id => id, :name => name, :stylist_id => stylist_id}))
    end
    return clients
  end

  define_singleton_method(:find) do |find_id|
    db_client = DB.exec("SELECT * FROM clients WHERE id = #{find_id}")
    id = db_client.first().fetch('id').to_i()
    name = db_client.first().fetch('name')
    stylist_id = db_client.first().fetch('stylist_id').to_i()
    return Client.new({:id => id, :name => name, :stylist_id => stylist_id})
  end

  define_method(:==) do |another_client|
    return @name == another_client.name
  end

  define_method(:save) do
    if(@stylist_id != nil)
      db_id = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    else
      db_id = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    end
    @id = db_id.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes[:name]
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
    if(attributes.has_key?(:stylist_id))
      @stylist_id = attributes[:stylist_id]
      DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{@id}")
  end

  define_singleton_method(:find_by_stylist_id) do |find_stylist_id|
    db_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{find_stylist_id};")
    clients = []
    db_clients.each() do |db_client|
      id = db_client.fetch('id').to_i()
      name = db_client.fetch('name')
      stylist_id = db_client.fetch('stylist_id').to_i()
      clients.push(Client.new({:id => id, :name => name, :stylist_id => stylist_id}))
    end
    return clients
  end

end
