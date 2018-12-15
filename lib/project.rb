class Project

  attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def self.all
    projects = []
    result = DB.exec("SELECT * FROM volunteers;")
    result.each() do |project|
    title  = volunteer.fetch("title")
    id = volunteer.fetch("id").to_i
      projects.push(Project.new({:title => name, :id => id}))
    end
    projects
  end


end
