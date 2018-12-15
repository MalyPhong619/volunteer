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
  end


end
