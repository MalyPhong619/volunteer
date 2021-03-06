class Volunteer

  attr_accessor :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name())
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.all
    volunteers = []
    result = DB.exec("SELECT * FROM volunteers;")
    result.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = id;").first
    name = result.fetch("name")
    project_id = result.fetch("project_id").to_i
    id = result.fetch("id").to_i
    Volunteer.new({:name => name, :id => id, :project_id => project_id})
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end


  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id};")
  end

end
