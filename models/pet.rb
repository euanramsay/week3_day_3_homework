require_relative('../db/sql_runner')

class Pet

  attr_reader :id, :name, :type, :pet_store_id

  def initialize( options )
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @type = options['type']
    @pet_store_id = options['pet_store_id'].to_i
  end

  def save()
    sql = "INSERT INTO pets (name, type, pet_store_id) VALUES ('#{@name}', '#{@type}', #{@pet_store_id}) RETURNING *"
    pet = SqlRunner.run( sql ).first
    @id = pet['id']
  end

  def show_store
    sql = "SELECT * FROM pet_stores WHERE id = #{@pet_store_id}"
    show_store = SqlRunner.run( sql )
    result = show_store.map { |shop| PetStore.new(shop) }
    return result
  end

  def self.find_pet(pet_id)
    sql = "SELECT * FROM pets WHERE id = #{pet_id}"
    found_pet = SqlRunner.run( sql ).first
    result = Pet.new(found_pet)
  end

  def update
    sql = "UPDATE pets SET name = '#{name}', 
    type = '#{@type}'"
    update_pet = SqlRunner.run( sql ).first
    result = Pet.new(update_pet)
  end

  def delete
    sql = "DELETE FROM pets WHERE id = #{@id}"
    delete_pet = SqlRunner.run( sql )
  end

  def self.list_all_pets
    sql = "SELECT * FROM pets"
    all_pets = SqlRunner.run( sql )
    result = all_pets.map { |pet| Pet.new(pet) }
    return result
  end


end