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


end
