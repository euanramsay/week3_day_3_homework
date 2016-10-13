require_relative('../db/sql_runner')

class PetStore

  attr_reader :id, :name, :address, :stock_type

  def initialize( options )
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @address = options['address']
    @stock_type = options['stock_type']
  end

  def save()
    sql ="INSERT INTO pet_stores (name, address, stock_type) VALUES ('#{@name}', '#{@address}', '#{@stock_type}') RETURNING *"
    pet_store = SqlRunner.run( sql ).first
    @id = pet_store['id']
  end

  def all_pets
    sql = "SELECT * FROM pets WHERE pet_store_id = #{@id}"
    all_pets = SqlRunner.run( sql )
    result = all_pets.map { |new_pet| Pet.new(new_pet) }
    return result
  end

  def self.find_store(store_id)
    sql = "SELECT * FROM pet_stores WHERE id = #{store_id}"
    store = SqlRunner.run( sql ).first
    result = PetStore.new(store)
    # binding.pry
  end

  def update
    sql = "UPDATE pet_stores SET name = '#{name}',
    address = '#{address}', 
    stock_type = '#{@stock_type}'"
    update_store = SqlRunner.run( sql ).first
    result = PetStore.new(update_store)
  end

  def delete
    sql = "DELETE FROM pet_stores WHERE id = #{@id}"
    delete_store = SqlRunner.run( sql )
  end

  def self.list_all_stores
    sql = "SELECT * FROM pet_stores"
    all_stores = SqlRunner.run( sql )
    result = all_stores.map { |store| PetStore.new(store) }
    return result
  end




end