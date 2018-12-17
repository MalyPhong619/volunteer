class Project

  attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.all
    projects = []
    result = DB.exec("SELECT * FROM projects;")
    result.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new(:title => title, :id => id))
    end
    projects
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM projects WHERE id = id;").first
    title = result.fetch("title")
    id = result.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def volunteers
    volunteers = []
    result = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    result.each do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    @id = self.id()
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end
end
