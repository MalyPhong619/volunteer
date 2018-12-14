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

  def self.all
    volunteers = []
  end






  # def save
  #   result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
  # end
  #


end
