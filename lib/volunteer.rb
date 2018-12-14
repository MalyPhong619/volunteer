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
  end

  def self.all
    select_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    select_volunteers.each() do |volunteer|
      volunteers.push(Volunteer.new({:name => volunteer.name, :project_id => volunteer.project_id, :id => volunteer.id}))
    end
    volunteers
  end
end
